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
//    func updateData()
    func loadData()
}

final class DetailPresenter: DetailPresenterProtocol {
    // MARK: – Variable's
    private weak var view: DetailViewProtocol?
    private let dataManager: CoreDataManager
    private let networkService: NetworkService
    private(set) var model: DetailModel
    
    var page: Int = 1
    var language: String = "ru-RUS"
    var isLoading: Bool = false
    
    init(view: DetailViewProtocol, model: DetailModel, dataManager: CoreDataManager, networkService: NetworkService) {
        self.view = view
        self.model = model
        self.dataManager = dataManager
        self.networkService = networkService
    }
    
    func loadData() {
        self.view?.loadModel(model: self.model)
    }
    
    // Как здесь сделать переключатель между разными объектами по эндпоинту?
    
//    private func updateModel() {
//        let endpoint: APIEndpoint
//        
//        switch endpoint {
//        case .getPopular(language: language, page: page):
//            
//            
//        default:
//            print("")
//        }
//        networkService.get(of: PopularFilms.self, endpoint: endpoint, method: .get, parameters: endpoint.params, headers: endpoint.headers) { [weak self] result in
//            guard let self else { return }
//            switch result {
//            case .success(let filmPop):
//                self.dataManager.sync(of: Popular.self, of: FilmsUpdateEnum.self, with: filmPop.results) { entity, dto in
//                    return [
//                        .originalTitle(dto.originalTitle ?? "Empty"),
//                        .posterPath(dto.posterPath ?? "Empty"),
//                        .overview(dto.overview ?? "Empty"),
//                        .releaseDate(dto.releaseDate ?? "Empty"),
//                        .backdropPath(dto.backdropPath ?? "Empty"),
//                        .voteAverage(dto.voteAverage)
//                    ]
//                } completion: { [weak self] result in
//                    guard let self else { return }
//                    switch result {
//                    case .success(()):
//                        print("Успешное обновление данных")
//                    case .failure(let error):
//                        print("Ошибка обновления: \(error.localizedDescription)")
//                    }
//                }
//            case .failure(let error):
//                print("Ошибка сетевого запроса при обновлении: \(error.localizedDescription)")
//            }
//        }
//    }
    
//    func updateData() {
//        updateModel()
//    }
}
