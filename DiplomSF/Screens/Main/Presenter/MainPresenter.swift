//
//  MainPresenter.swift
//  DiplomSF
//
//  Created by Алексей on 10.09.2025.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func loadFilmsData(_ data: [PopularFilmsModel])
}

protocol MainPresenterProtocol: AnyObject {
    func loadData()
    func updateData()
}

final class MainPresenter: MainPresenterProtocol {
    private weak var view: MainViewProtocol?
    private let networkService: NetworkService
    private let dataManager: CoreDataManager
    private(set) var model: [PopularFilmsModel] = []
    
    var page: Int = 1
    var language: String = "ru-RUS"
    var isLoading: Bool = false
    
    init(networkService: NetworkService, dataManager: CoreDataManager, view: MainViewProtocol) {
        self.networkService = networkService
        self.dataManager = dataManager
        self.view = view
    }
    
    // Подумать как иплементировать сюда update
    private func loadModel() {
        dataManager.fetch(of: Popular.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let entity):
                if entity.isEmpty {
                    let endpoint = APIEndpoint.getPopular(language: language, page: 1)
                    networkService.get(of: PopularFilms.self, endpoint: endpoint, method: .get, parameters: endpoint.params, headers: endpoint.headers) { [weak self] result in
                        guard let self else { return }
                        switch result {
                        case .success(let filmPop):
                            self.dataManager.create(from: filmPop.results) { [weak self] result in
                                guard let self else { return }
                                switch result {
                                case .success(let film):
                                    DispatchQueue.main.async {
                                        self.model = film.map(PopularFilmsModel.init)
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
    }
    
    func loadData() {
        page = 1
        loadModel()
        updateModel()
    }
    
    private func loadNextPage(currentPage: Int) {
        let endpoint = APIEndpoint.getPopular(language: language, page: currentPage)
        networkService.get(of: PopularFilms.self, endpoint: endpoint, method: .get, parameters: endpoint.params, headers: endpoint.headers) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let filmPop):
                self.dataManager.create(from: filmPop.results) { [weak self] result in
                    guard let self else { return }
                    switch result {
                    case .success(let entity):
                        DispatchQueue.main.async {
                            let objects = entity.map(PopularFilmsModel.init)
                            
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
        networkService.get(of: PopularFilms.self, endpoint: endpoint, method: .get, parameters: endpoint.params, headers: endpoint.headers) { [weak self] result in
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
}
