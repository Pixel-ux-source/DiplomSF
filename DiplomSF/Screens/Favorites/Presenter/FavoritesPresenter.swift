//
//  FavoritesPresenter.swift
//  DiplomSF
//
//  Created by Алексей on 03.11.2025.
//

import UIKit

protocol FavoritesViewProtocol: AnyObject {
    func reload(with models: [PopularFilmsModel])
    func updateFavorite(at index: Int, isFavorite: Bool)
}

protocol FavoritesPresenterProtocol: AnyObject {
    func loadData()
    func toggleFavorite(id: Int64)
    var models: [PopularFilmsModel] { get }
    func setFavorite(id: Int64, isFavorite: Bool)
}

final class FavoritesPresenter: FavoritesPresenterProtocol {
    private weak var view: FavoritesViewProtocol?
    private let dataManager: CoreDataManager
    private let userSettings: UserSettings
    private(set) var models: [PopularFilmsModel] = []
    
    init(view: FavoritesViewProtocol, dataManager: CoreDataManager, userSettings: UserSettings) {
        self.view = view
        self.dataManager = dataManager
        self.userSettings = userSettings
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoriteChanged(_:)), name: .favoriteChanged, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func loadData() {
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
        dataManager.fetch(of: Popular.self, sortDescriptors: [sortDescriptor]) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let entity):
                DispatchQueue.main.async {
                    var items = entity.map(PopularFilmsModel.init)
                    // apply favorites and filter only true
                    for idx in items.indices {
                        let id = items[idx].id
                        items[idx].isFavorite = self.userSettings.isFavorite(id)
                    }
                    items = items.filter { $0.isFavorite }
                    self.models = items
                    self.view?.reload(with: self.models)
                }
            case .failure(let error):
                print("Ошибка загрузки избранного: \(error.localizedDescription)")
            }
        }
    }
    
    func toggleFavorite(id: Int64) {
        guard let index = models.firstIndex(where: { $0.id == id }) else { return }
        models[index].isFavorite.toggle()
        userSettings.setFavorites(isFavorite: models[index].isFavorite, id: id)
        // If toggled off, remove from list; otherwise update cell
        if models[index].isFavorite == false {
            models.remove(at: index)
            view?.reload(with: models)
        } else {
            view?.updateFavorite(at: index, isFavorite: true)
        }
        NotificationCenter.default.post(name: .favoriteChanged, object: nil, userInfo: ["id": id, "isFavorite": models.first(where: { $0.id == id })?.isFavorite ?? false])
    }

    func setFavorite(id: Int64, isFavorite: Bool) {
        userSettings.setFavorites(isFavorite: isFavorite, id: id)
        if let index = models.firstIndex(where: { $0.id == id }) {
            if isFavorite {
                models[index].isFavorite = true
                view?.updateFavorite(at: index, isFavorite: true)
            } else {
                models.remove(at: index)
                view?.reload(with: models)
            }
        } else if isFavorite {
            // Item became favorite elsewhere; easiest is to reload the list
            loadData()
        }
    }

    @objc
    private func handleFavoriteChanged(_ notification: Notification) {
        // Favorites list could change; simplest is to reload from storage
        loadData()
    }
}


