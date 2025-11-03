//
//  FavoritesController.swift
//  DiplomSF
//
//  Created by Алексей on 03.11.2025.
//

import UIKit
import PinLayout

final class FavoritesController: UIViewController {
    // MARK: – Instances
    private let collectionView = FavoritesCollection(collectionViewLayout: UICollectionViewFlowLayout())
    private let dataSource = FavoritesDataSource()
    private let delegateCV = FavoritesDelegate()
    
    // MARK: – Variables
    var coordinator: CoordinatorProtocol!
    var presenter: FavoritesPresenterProtocol!
    
    // MARK: – Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureCollection()
        presenter.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        presenter.loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.pin.all()
    }
    
    // MARK: – Configuration
    private func configureView() {
        view.backgroundColor = .systemBackground
        
    }
    
    private func configureCollection() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = dataSource
        collectionView.delegate = delegateCV
        
        delegateCV.coordinator = coordinator
        dataSource.presenter = presenter
    }
}

// MARK: – View Protocol
extension FavoritesController: FavoritesViewProtocol {
    func reload(with models: [PopularFilmsModel]) {
        dataSource.models = models
        delegateCV.models = models
        collectionView.reloadData()
    }
    
    func updateFavorite(at index: Int, isFavorite: Bool) {
        guard index >= 0 && index < dataSource.models.count else { return }
        dataSource.models[index].isFavorite = isFavorite
        delegateCV.models = dataSource.models
        if let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? FavoriteFilmCell {
            cell.setFavoriteSelected(isFavorite)
        }
    }
}

extension FavoritesController: DetailControllerDelegate {
    func detailController(_ viewController: DetailController, didChangeFavoriteFor id: Int64, isFavorite: Bool) {
        presenter.setFavorite(id: id, isFavorite: isFavorite)
    }
}



