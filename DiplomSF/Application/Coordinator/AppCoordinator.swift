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
            
            let favoritesView = FavoritesBuilder.build(dataManager: dataManager)
            favoritesView.coordinator = self
            let favoritesNavigationController = UINavigationController(rootViewController: favoritesView)
            favoritesNavigationController.isNavigationBarHidden = true
            favoritesNavigationController.tabBarItem = UITabBarItem(
                title: "Избранное",
                image: UIImage(systemName: "heart"),
                selectedImage: UIImage(systemName: "heart.fill")
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
            
            tabBarController.viewControllers = [mainNavigationController, favoritesNavigationController, searchNavigationController]
            
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
                                     id: model.id,
                                     isFavorite: model.isFavorite)
            
            let detailView = DetailBuilder.build(dataManager: dataManager, model: object)
            detailView.coordinator = self
            
            if let nav = tabBarController.selectedViewController as? UINavigationController {
                nav.setNavigationBarHidden(false, animated: true)
                nav.navigationBar.tintColor = .systemRed
                if let mainVC = nav.topViewController as? MainController {
                    detailView.delegateOutput = mainVC
                } else if let favVC = nav.topViewController as? FavoritesController {
                    detailView.delegateOutput = favVC
                }
                nav.pushViewController(detailView, animated: true)
            }
        }
        
        func openDetailImage(for images: [String], index: IndexPath) {
            let object = ImageModel(images: images, index: index)
            let detaiImageView = ImageDetailBuilder.build(dataManager: dataManager, model: object)
            
            detaiImageView.coordinator = self
            
            if let nav = tabBarController.selectedViewController as? UINavigationController {
                nav.navigationBar.tintColor = .systemRed
                nav.pushViewController(detaiImageView, animated: true)
            }
        }
    }

