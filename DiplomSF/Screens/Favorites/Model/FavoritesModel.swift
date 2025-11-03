//
//  FavoritesModel.swift
//  DiplomSF
//
//  Created by Алексей on 21.10.2025.
//

import Foundation

struct FavoritesModel: ModelsProtocol {
    let originalTitle: String
    let title: String
    let posterPath: String
    let releaseDate: String
    let overview: String
    let voteAverage: Double
    let id: Int64
    var isFavorite: Bool
    
    init(model: ModelsProtocol) {
        self.originalTitle = model.originalTitle
        self.title = model.title
        self.posterPath = model.posterPath
        self.releaseDate = model.releaseDate
        self.overview = model.overview
        self.voteAverage = model.voteAverage
        self.id = model.id
        self.isFavorite = false
    }
}
