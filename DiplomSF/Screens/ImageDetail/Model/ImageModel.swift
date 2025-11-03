//
//  ImageModel.swift
//  DiplomSF
//
//  Created by Алексей on 22.10.2025.
//

import Foundation

struct ImageModel {
    let images: [String]
    let index: IndexPath
    
    init(images: [String], index: IndexPath) {
        self.images = images
        self.index = index
    }
}
