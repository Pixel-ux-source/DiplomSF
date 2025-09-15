//
//  PopularFilmsModel.swift
//  DiplomSF
//
//  Created by Алексей on 10.09.2025.
//

import UIKit

struct PopularFilmsModel {
    let originalTitle: String
    let posterPath: String
    let releaseDate: String
    let overview: String
    let voteAverage: Double
    let backdropPath: String
    let id: Int64
    
    init(model: Popular) {
        self.id = model.id
        self.originalTitle = model.originalTitle ?? "Empty"
        self.posterPath = model.posterPath ?? "Empty"
        self.releaseDate = model.releaseDate ?? "Empty"
        self.overview = model.overview ?? "Empty"
        self.voteAverage = model.voteAverage
        self.backdropPath = model.backdropPath ?? "Empty"
    }
}
