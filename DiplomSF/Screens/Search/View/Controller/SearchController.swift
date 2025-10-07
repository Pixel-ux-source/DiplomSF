//
//  SearchController.swift
//  DiplomSF
//
//  Created by Алексей on 17.09.2025.
//

import UIKit
import PinLayout

final class SearchController: UIViewController {
    // MARK: – Instance's
    private let tableView = SearchTable()
    private let dataSource = SearchDataSource()
    private let delegate = SearchDelegate()
    
    // MARK: – Variable's
    var presenter: SearchPresenterProtocol!
    var coordinator: CoordinatorProtocol!
    
    // MARK: – Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
    }
    
    // MARK: – Configuration's
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.tableHeaderView = UIView()
        tableView.pin.all()
        
        tableView.separatorInset = .zero
        tableView.separatorStyle = .none
        
        tableView.dataSource = dataSource
        
        delegate.coordinator = coordinator
        tableView.delegate = delegate
    }
}


extension SearchController: SearchViewProtocol {
    func reloadData(model: [SearchModel]) {
        self.dataSource.searchModel = model
        self.delegate.searchModel = model
        tableView.reloadData()
    }
}

extension SearchController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        if !query.isEmpty {
            presenter.updateSearchResults(for: query)
        } else {
            presenter.resetSearchResults()
        }
    }
}
