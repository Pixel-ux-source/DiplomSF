//
//  SearchPresenter.swift
//  DiplomSF
//
//  Created by Алексей on 25.09.2025.
//

import Foundation

protocol SearchViewProtocol: AnyObject {
    func reloadData(model: [SearchModel])
}

protocol SearchPresenterProtocol: AnyObject {
    func updateSearchResults(for searchQuery: String)
    func resetSearchResults()
}

final class SearchPresenter: SearchPresenterProtocol {
    private weak var view: SearchViewProtocol?
    private let dataManager: CoreDataManager
    
    private(set) var model: [SearchModel] = []
    
    init(view: SearchViewProtocol, dataManager: CoreDataManager) {
        self.view = view
        self.dataManager = dataManager
    }
    
    func resetSearchResults() {
        self.model = []
        DispatchQueue.main.async {
            self.view?.reloadData(model: [])
        }
    }
    
    func updateSearchResults(for searchQuery: String) {
        dataManager.search(of: Popular.self, with: searchQuery) { result in
            switch result {
            case .success(let entity):
                DispatchQueue.main.async {
                    self.model = entity.map(SearchModel.init)
                    self.view?.reloadData(model: self.model)
                }
            case .failure(let error):
                print("Ошибка при поиске: \(error)")
            }
        }
    }
}
