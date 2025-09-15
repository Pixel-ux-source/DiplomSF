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
    var dataManager: PopularManager
    
    init(window: UIWindow, dataManager: PopularManager) {
        self.window = window
        self.dataManager = dataManager
        self.navigationController = UINavigationController()
        self.navigationController.isNavigationBarHidden = true
    }
    
    func start() {
        let vc = MainBuilder.build(dataManager: dataManager)
        vc.coordinator = self

        tabBarController.viewControllers = [vc]
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()

        navigationController.pushViewController(vc, animated: false)
    }
}
