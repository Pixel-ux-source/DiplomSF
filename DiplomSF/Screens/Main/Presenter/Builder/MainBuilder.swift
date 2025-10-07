//
//  MainBuilder.swift
//  DiplomSF
//
//  Created by Алексей on 10.09.2025.
//

import UIKit

struct MainBuilder: BuilderProtocol {
    static func build(dataManager: CoreDataManager) -> MainController {
        let view = MainController()
        let presenter = MainPresenter(networkService: NetworkService(), dataManager: dataManager, view: view)
        view.presenter = presenter
        return view
    }
    
    typealias vc = MainController
}
