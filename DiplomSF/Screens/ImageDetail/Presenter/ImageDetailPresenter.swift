//
//  ImageDetailPresenter.swift
//  DiplomSF
//
//  Created by Алексей on 22.10.2025.
//

import UIKit

protocol ImageDetailViewProtocol: AnyObject {
    func loadModel(model: ImageModel)
}

protocol ImageDetailPresenterProtocol: AnyObject {
    func loadData()
}

final class ImageDetailPresenter: ImageDetailPresenterProtocol {
    // MARK: – Variable's
    private weak var view: ImageDetailViewProtocol?
    private(set) var model: ImageModel
    
    init(view: ImageDetailController, model: ImageModel) {
        self.view = view
        self.model = model
    }
    
    func loadData() {
        self.view?.loadModel(model: model)
    }
    
}
