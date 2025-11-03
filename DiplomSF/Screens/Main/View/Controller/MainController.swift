//
//  ViewController.swift
//  DiplomSF
//
//  Created by Алексей on 02.09.2025.
//

// Разделы Фильмы / Сериалы

import UIKit
import CoreData
import PinLayout

final class MainController: UIViewController {
    // MARK: – Instance's
    private var collectionView = MainCollection(collectionViewLayout: MainLayoutProvider.loadLayout())
    
    private let dataSource = MainDataSource()
    private let delegate = MainDelegateCV()
    private let refreshControl = UIRefreshControl()
    
    // MARK: – Variable's
    var coordinator: CoordinatorProtocol!
    var presenter: MainPresenter!
    
    // MARK: – Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureCollection()
        
        presenter.loadData()
    }
    
    // Понять как запретить ротейт на главном / поиске / детальная карточка
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var shouldAutorotate: Bool {
        return false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureConstraintsCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    // MARK: – Configuration's
    private func configureCollection() {
        view.addSubview(collectionView)
        
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        delegate.coordinator = coordinator
        dataSource.presenter = presenter
        
        delegate.onReachEnd = { [weak self] in
            guard let self else { return }
            self.presenter.loadPage()
        }
        
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }
    
    private func configureConstraintsCollection() {
        collectionView.pin
            .vertically()
            .horizontally()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    // MARK: – @OBJC
    @objc
    private func refreshAction() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.presenter.updateData()
            self.collectionView.setContentOffset(.zero, animated: true)
            self.refreshControl.endRefreshing()
        }
    }
}

// MARK: – Extension's
extension MainController: MainViewProtocol {
    func loadFilmsData(_ data: [PopularFilmsModel]) {
        self.dataSource.popularFilmsModel = data
        delegate.popularFilmsModel = dataSource.popularFilmsModel
        print("All ids:", dataSource.popularFilmsModel.map { $0.id })
        
        collectionView.reloadData()
    }
    
    func updateFavorite(at index: Int, isFavorite: Bool) {
        guard index >= 0 && index < dataSource.popularFilmsModel.count else { return }
        dataSource.popularFilmsModel[index].isFavorite = isFavorite
        delegate.popularFilmsModel = dataSource.popularFilmsModel
        let indexPath = IndexPath(item: index, section: 0)
        if let cell = collectionView.cellForItem(at: indexPath) as? PopularFilmCell {
            cell.setFavoriteSelected(isFavorite)
        }
    }
}

extension MainController: DetailControllerDelegate {
    func detailController(_ viewController: DetailController, didChangeFavoriteFor id: Int64, isFavorite: Bool) {
        presenter.setFavorite(id: id, isFavorite: isFavorite)
    }
}
