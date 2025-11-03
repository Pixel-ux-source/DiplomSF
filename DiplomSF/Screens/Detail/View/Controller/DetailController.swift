//
//  DetailController.swift
//  DiplomSF
//
//  Created by Алексей on 01.10.2025.
//

import UIKit
import PinLayout

final class DetailController: UIViewController {
    // MARK: – Instance's
    private let collectionView = DetailCollection(collectionViewLayout: DetailLayoutProvider.loadLayout())
    private let dataSource = DetailDataSource()
    private let delegate = DetailDelegate()
    
    // MARK: – Variable's
    var coordinator: AppCoordinator!
    var presenter: DetailPresenterProtocol!
    weak var delegateOutput: DetailControllerDelegate?
    
    // MARK: – Life Cycle
    override func viewDidLoad() {
        configureView()
        configureCollectionView()
        presenter.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureConstraintsCollection()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let state = presenter.currentFavorite()
        delegateOutput?.detailController(self, didChangeFavoriteFor: state.id, isFavorite: state.isFavorite)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    // MARK: – Configuration's
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
    }
    
    private func configureConstraintsCollection() {
        collectionView.pin.all()
    }
    
    // MARK: – Setup's
}

extension DetailController: DetailViewProtocol {
    func loadModel(model: DetailModel) {
        dataSource.model = model
        delegate.model = model
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
        
        delegate.coordinator = coordinator
        dataSource.presenter = presenter
    }
}

protocol DetailControllerDelegate: AnyObject {
    func detailController(_ viewController: DetailController, didChangeFavoriteFor id: Int64, isFavorite: Bool) 
}
