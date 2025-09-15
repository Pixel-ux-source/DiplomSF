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
}

final class MainPresenter: MainPresenterProtocol {
    private weak var view: MainViewProtocol?
    private let networkService: NetworkService
    private let dataManager: PopularManager
    private(set) var model: [PopularFilmsModel] = []
    
    init(networkService: NetworkService, dataManager: PopularManager, view: MainViewProtocol) {
        self.networkService = networkService
        self.dataManager = dataManager
        self.view = view
    }
    
    private func loadModel() {
        dataManager.fetch(of: Popular.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let entity):
                if entity.isEmpty {
                    networkService.get(of: PopularFilms.self, endpoint: APIEndpoint.getPopular, method: .get, parameters: APIEndpoint.getPopular.params, headers: APIEndpoint.getPopular.headers) { [weak self] result in
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
    
    func loadData() {
        loadModel()
    }
    
}
