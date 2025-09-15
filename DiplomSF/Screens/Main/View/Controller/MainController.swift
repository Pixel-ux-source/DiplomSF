//
//  ViewController.swift
//  DiplomSF
//
//  Created by Алексей on 02.09.2025.
//

import UIKit
import CoreData
import PinLayout

final class MainController: UIViewController {
    // MARK: – Instance's
    private let collectionView = MainCollection(collectionViewLayout: LayoutProvider.loadLayout())
    private let dataSource = MainDataSource()
    private let delegate = MainDelegateCV()
    
    // MARK: – Variable's
    var coordinator: AppCoordinator!
    var presenter: MainPresenter!
    
    // MARK: – Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadData()
        configureView()
        configureCollection()    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureConstraintsCollection()
    }
    
    // MARK: – Configuration's
    private func configureCollection() {
        view.addSubview(collectionView)
        
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
    }
    
    private func configureConstraintsCollection() {
        collectionView.pin
            .vertically()
            .horizontally()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
}

extension MainController: MainViewProtocol {
    func loadFilmsData(_ data: [PopularFilmsModel]) {
        self.dataSource.popularFilmsModel = data
        collectionView.reloadData()
    }
}
