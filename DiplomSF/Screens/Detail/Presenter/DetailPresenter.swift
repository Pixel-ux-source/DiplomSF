//
//  DetailPresenter.swift
//  DiplomSF
//
//  Created by Алексей on 01.10.2025.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func loadModel(model: DetailModel)    
}

protocol DetailPresenterProtocol: AnyObject {
    func loadData()
    func toggleFavorite()
    func currentFavorite() -> (id: Int64, isFavorite: Bool)
}

final class DetailPresenter: DetailPresenterProtocol {
    // MARK: – Variable's
    private weak var view: DetailViewProtocol?
    private(set) var model: DetailModel
    
    var page: Int = 1
    var language: String = "ru-RUS"
    var isLoading: Bool = false
    
    // MARK: – Instance's
    private let dataManager: CoreDataManager
    private let networkService: NetworkService
    private let userSettings: UserSettings
    
    init(view: DetailViewProtocol, model: DetailModel, dataManager: CoreDataManager, networkService: NetworkService, userSettings: UserSettings) {
        self.view = view
        self.model = model
        self.dataManager = dataManager
        self.networkService = networkService
        self.userSettings = userSettings
    }
    
    func loadData() {
        loadImages()
    }
    
    private func loadImages() {
        let endpoint = APIEndpoint.images(id: model.id)
        networkService.get(of: MovieImagesResponse.self, endpoint: endpoint, parameters: endpoint.params, headers: endpoint.headers) { [weak self] result in
            guard let self else { return } 
            switch result {
            case .success(let model):
                let array = MovieImagesMapping.mapping(from: model)
                DispatchQueue.main.async {
                    self.model.images.append(contentsOf: array)
                    self.view?.loadModel(model: self.model)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Ошибка при распаковке изображений кадров объекта: \(error)")
                }
            }
        }
    }
    
    func toggleFavorite() {
        model.isFavorite.toggle()
        userSettings.setFavorites(isFavorite: model.isFavorite, id: model.id)
        print(model.isFavorite)
        view?.loadModel(model: model)
        NotificationCenter.default.post(name: .favoriteChanged, object: nil, userInfo: ["id": model.id, "isFavorite": model.isFavorite])
    }

    func currentFavorite() -> (id: Int64, isFavorite: Bool) {
        return (id: model.id, isFavorite: model.isFavorite)
    }
}
