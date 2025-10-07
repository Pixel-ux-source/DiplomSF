//
//  DetailBuilder.swift
//  DiplomSF
//
//  Created by Алексей on 01.10.2025.
//

import Foundation

struct DetailBuilder {
    static func build(dataManager: CoreDataManager, model: DetailModel) -> DetailController {
        let view = DetailController()
        let presetner = DetailPresenter(view: view, model: model, dataManager: dataManager, networkService: NetworkService())
        view.presenter = presetner
        
        return view
    }
    
    typealias vc = DetailController
}
