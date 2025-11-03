//
//  SearchModel.swift
//  DiplomSF
//
//  Created by Алексей on 01.10.2025.
//

import Foundation

struct SearchModel: ModelsProtocol {
    let originalTitle: String
    let title: String
    let posterPath: String
    let releaseDate: String
    let overview: String
    let voteAverage: Double
    let id: Int64
    var isFavorite: Bool
    
    init(model: Popular) {
        self.id = model.id
        self.originalTitle = model.originalTitle ?? "Empty"
        self.title = model.title ?? "Empty"
        self.posterPath = model.posterPath ?? "Empty"
        self.releaseDate = model.releaseDate ?? "Empty"
        self.overview = model.overview ?? "Empty"
        self.voteAverage = model.voteAverage
        self.isFavorite = false
    }
}
