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
    
    // MARK: – Life Cycle
    override func viewDidLoad() {
        configureView()
        configureCollectionView()
        presenter.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureConstraintsCollection()
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
        collectionView.pin
            .vertically()
            .horizontally()
    }
    
    // MARK: – Setup's
}

extension DetailController: DetailViewProtocol {
    func loadModel(model: DetailModel) {
        dataSource.infoModel = model
        collectionView.reloadData()
    }
}
