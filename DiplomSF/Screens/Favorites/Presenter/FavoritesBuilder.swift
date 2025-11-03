//
//  FavoritesBuilder.swift
//  DiplomSF
//
//  Created by Алексей on 03.11.2025.
//

import Foundation

struct FavoritesBuilder {
    static func build(dataManager: CoreDataManager) -> FavoritesController {
        let view = FavoritesController()
        let presenter = FavoritesPresenter(view: view, dataManager: dataManager, userSettings: UserSettings())
        view.presenter = presenter
        return view
    }
}


