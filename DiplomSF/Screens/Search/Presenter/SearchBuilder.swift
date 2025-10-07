//
//  Builder.swift
//  DiplomSF
//
//  Created by Алексей on 25.09.2025.
//

import UIKit

struct SearchBuilder: BuilderProtocol {
    static func build(dataManager: CoreDataManager) -> SearchController {
        let view = SearchController()
        let presenter = SearchPresenter(view: view, dataManager: dataManager)
        view.presenter = presenter
        return view
    }
    
    typealias vc = SearchController
    
}
