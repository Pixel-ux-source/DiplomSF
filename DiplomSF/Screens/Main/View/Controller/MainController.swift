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
import SkeletonView

final class MainController: UIViewController {
    // MARK: – Instance's
    private var collectionView: MainCollection!
    
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
        configureSkeleton()
        
        collectionView.showAnimatedSkeleton(usingColor: .silver, animation: .none)
        presenter.loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureConstraintsCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: – Configuration's
    private func configureCollection() {
        collectionView = MainCollection(collectionViewLayout: MainLayoutProvider.loadLayout(onReachEnd: { [weak self] in
            guard let self else { return }
            self.presenter.loadPage()
        }))
        
        view.addSubview(collectionView)
        
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        delegate.coordinator = coordinator
        
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }
    
    private func configureConstraintsCollection() {
        collectionView.pin
            .vertically()
            .horizontally()
    }
    
    private func configureSkeleton() {
        collectionView.isSkeletonable = true
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
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}

// MARK: – Extension's
extension MainController: MainViewProtocol {
    func loadFilmsData(_ data: [PopularFilmsModel]) {
        self.dataSource.popularFilmsModel = data
        delegate.popularFilmsModel = dataSource.popularFilmsModel
        
        collectionView.hideSkeleton()
        collectionView.reloadData()
    }
}
