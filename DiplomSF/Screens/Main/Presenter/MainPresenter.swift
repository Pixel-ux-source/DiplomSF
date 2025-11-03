//
//  MainPresenter.swift
//  DiplomSF
//
//  Created by Алексей on 10.09.2025.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func loadFilmsData(_ data: [PopularFilmsModel])
    func updateFavorite(at index: Int, isFavorite: Bool)
}

protocol MainPresenterProtocol: AnyObject {
    func loadData()
    func updateData()
    func toggleFavorite(index: Int64)
    func setFavorite(id: Int64, isFavorite: Bool)
}

final class MainPresenter: MainPresenterProtocol {
    private weak var view: MainViewProtocol?
    private let networkService: NetworkService
    private let dataManager: CoreDataManager
    private(set) var model: [PopularFilmsModel] = []
    private let userSettings: UserSettings
    
    var page: Int = 1
    var language: String = "ru-RUS"
    var isLoading: Bool = false
    
    init(networkService: NetworkService, dataManager: CoreDataManager, view: MainViewProtocol, userSettings: UserSettings) {
        self.networkService = networkService
        self.dataManager = dataManager
        self.view = view
        self.userSettings = userSettings
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoriteChanged(_:)), name: .favoriteChanged, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func applyFavorites() {
        for index in model.indices {
            let id = model[index].id
            model[index].isFavorite = userSettings.isFavorite(id)
        }
    }

    private func loadModel() {
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
        dataManager.fetch(of: Popular.self, sortDescriptors: [sortDescriptor]) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let entity):
                if entity.isEmpty {
                    let endpoint = APIEndpoint.getPopular(language: language, page: 1)
                    networkService.get(of: PopularFilmsResponse.self, endpoint: endpoint, method: .get, parameters: endpoint.params, headers: endpoint.headers) { [weak self] result in
                        guard let self else { return }
                        switch result {
                        case .success(let filmPop):
                            self.dataManager.create(from: filmPop.results) { [weak self] result in
                                guard let self else { return }
                                switch result {
                                case .success(let film):
                                    DispatchQueue.main.async {
                                        let value = Array(Set(film))
                                        self.model = value.map(PopularFilmsModel.init)
                                        self.model.sort { $0.id > $1.id }
                                        self.applyFavorites()
                                        self.view?.loadFilmsData(self.model)
                                    }
                                case .failure(let error):
                                    print("Ошибка сохранения: \(error.localizedDescription)")
                                }
                            }
                        case .failure(let error):
                            print("Ошибка сети: \(error.localizedDescription)")
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.model = entity.map(PopularFilmsModel.init)
                        self.model.sort { $0.id > $1.id }
                        self.applyFavorites()
                        self.view?.loadFilmsData(self.model)
                    }
                }
            case .failure(let error):
                print("Ошибка загрузки данных: \(error.localizedDescription)")
            }
        }
    }
    
    func changeLanguage(_ language: String) {
        self.language = language
        loadData()
    }
    
    func loadPage() {
        guard !isLoading else { return }
        page += 1
        isLoading = true
        loadNextPage(currentPage: page)
        print(page)
    }
    
    func loadData() {
        page = 1
        loadModel()
        loadFavoriteState()
    }
    
    private func loadNextPage(currentPage: Int) {
        let endpoint = APIEndpoint.getPopular(language: language, page: currentPage)
        networkService.get(of: PopularFilmsResponse.self, endpoint: endpoint, method: .get, parameters: endpoint.params, headers: endpoint.headers) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let filmPop):
                self.dataManager.create(from: filmPop.results) { [weak self] result in
                    guard let self else { return }
                    switch result {
                    case .success(let entity):
                        DispatchQueue.main.async {
                            let value = Array(Set(entity))
                            var objects = value.map(PopularFilmsModel.init)
                            // apply favorites for appended items
                            for idx in objects.indices {
                                let id = objects[idx].id
                                objects[idx].isFavorite = self.userSettings.isFavorite(id)
                            }
                            
                            self.model.append(contentsOf: objects)
                            self.view?.loadFilmsData(self.model)
                            self.isLoading = false
                        }
                    case .failure(let error):
                        print("Ошибка сохранения данных при загрузке данных: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                print("Ошибка загрузки страницы \(page): \(error)")
            }
        }
    }
    
    private func updateModel() {
        let endpoint = APIEndpoint.getPopular(language: language, page: page)
        networkService.get(of: PopularFilmsResponse.self, endpoint: endpoint, method: .get, parameters: endpoint.params, headers: endpoint.headers) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let filmPop):
                self.dataManager.sync(of: Popular.self, of: FilmsUpdateEnum.self, with: filmPop.results) { entity, dto in
                    return [
                        .originalTitle(dto.originalTitle ?? "Empty"),
                        .posterPath(dto.posterPath ?? "Empty"),
                        .overview(dto.overview ?? "Empty"),
                        .releaseDate(dto.releaseDate ?? "Empty"),
                        .backdropPath(dto.backdropPath ?? "Empty"),
                        .voteAverage(dto.voteAverage)
                    ]
                } completion: { result in
                    switch result {
                    case .success(()):
                        print("Успешное обновление данных")
                    case .failure(let error):
                        print("Ошибка обновления: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                print("Ошибка сетевого запроса при обновлении: \(error.localizedDescription)")
            }
        }
    }
    
    func updateData() {
        updateModel()
        loadModel()
    }
    
    private func loadFavoriteState() {
//        let isFav = userSettings.isFavorite(<#T##id: Int64##Int64#>)
//        userSettings.saveFavorite(isFav)
//        self.view?.loadFilmsData(model)
    }
    
    func toggleFavorite(index: Int64) {
        guard let itemIndex = model.firstIndex(where: { $0.id == index }) else { return }
        model[itemIndex].isFavorite.toggle()
        userSettings.setFavorites(isFavorite: model[itemIndex].isFavorite, id: model[itemIndex].id)
        self.view?.updateFavorite(at: itemIndex, isFavorite: model[itemIndex].isFavorite)
        NotificationCenter.default.post(name: .favoriteChanged, object: nil, userInfo: ["id": model[itemIndex].id, "isFavorite": model[itemIndex].isFavorite])
    }

    func setFavorite(id: Int64, isFavorite: Bool) {
        guard let itemIndex = model.firstIndex(where: { $0.id == id }) else { return }
        model[itemIndex].isFavorite = isFavorite
        userSettings.setFavorites(isFavorite: isFavorite, id: id)
        self.view?.updateFavorite(at: itemIndex, isFavorite: isFavorite)
    }

    @objc
    private func handleFavoriteChanged(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let id = userInfo["id"] as? Int64,
              let isFavorite = userInfo["isFavorite"] as? Bool else { return }
        setFavorite(id: id, isFavorite: isFavorite)
    }
}
