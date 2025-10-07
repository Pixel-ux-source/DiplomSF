//
//  AppCoordinator.swift
//  DiplomSF
//
//  Created by Алексей on 10.09.2025.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol  {
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let tabBarController = UITabBarController()
    var dataManager: CoreDataManager
    
    init(window: UIWindow, dataManager: CoreDataManager) {
        self.window = window
        self.dataManager = dataManager
        self.navigationController = UINavigationController()
        self.navigationController.isNavigationBarHidden = true
    }
    
    func start() {
        let mainView = MainBuilder.build(dataManager: dataManager)
        mainView.navigationItem.backButtonTitle = "На главную"
        mainView.coordinator = self
        
        let mainNavigationController = UINavigationController(rootViewController: mainView)
        mainNavigationController.isNavigationBarHidden = true
        mainNavigationController.tabBarItem = UITabBarItem(
            title: "Главная",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        let searchView = SearchBuilder.build(dataManager: dataManager)
        searchView.coordinator = self
        
        let searchController = SearchConfiguration.make(for: searchView)
        searchController.delegate = searchView
        searchView.navigationItem.searchController = searchController
        searchView.navigationItem.hidesSearchBarWhenScrolling = false
        searchView.navigationItem.backButtonTitle = "К поиску"

        let searchNavigationController = UINavigationController(rootViewController: searchView)
        searchNavigationController.isNavigationBarHidden = false
        searchNavigationController.tabBarItem = UITabBarItem(
            title: "Поиск",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: nil
        )
        
        tabBarController.viewControllers = [mainNavigationController, searchNavigationController]
        
        tabBarController.tabBar.tintColor = .systemRed
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    func openDetailScreen(for model: ModelsProtocol) {
        let object = DetailModel(originalTitle: model.originalTitle,
                                 title: model.title,
                                 posterPath: model.posterPath,
                                 releaseDate: model.releaseDate,
                                 overview: model.overview,
                                 voteAverage: model.voteAverage,
                                 id: model.id)
        
        let detailView = DetailBuilder.build(dataManager: dataManager, model: object)
        detailView.coordinator = self
        
        if let nav = tabBarController.selectedViewController as? UINavigationController {
            nav.setNavigationBarHidden(false, animated: true)
            nav.navigationBar.tintColor = .systemRed
            nav.pushViewController(detailView, animated: true)
        }
    }
}

