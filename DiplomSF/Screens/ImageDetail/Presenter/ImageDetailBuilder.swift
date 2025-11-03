//
//  ImageDetailBuilder.swift
//  DiplomSF
//
//  Created by Алексей on 22.10.2025.
//

import UIKit

struct ImageDetailBuilder {
    static func build(dataManager: CoreDataManager, model: ImageModel) -> ImageDetailController {
        let vc = ImageDetailController()
        let presenter = ImageDetailPresenter(view: vc, model: model)
        vc.presenter = presenter
        return vc
    }
    
    typealias vc = ImageDetailController
    
    
}
