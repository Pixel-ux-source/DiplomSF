//
//  DetailModel.swift
//  DiplomSF
//
//  Created by Алексей on 01.10.2025.
//

import Foundation

struct DetailModel: ModelsProtocol {
    let originalTitle: String
    let title: String
    let posterPath: String
    let releaseDate: String
    let overview: String
    let voteAverage: Double
    let id: Int64
    
    init(originalTitle: String, title: String, posterPath: String, releaseDate: String, overview: String, voteAverage: Double, id: Int64) {
        self.originalTitle = originalTitle
        self.title = title
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.overview = overview
        self.voteAverage = voteAverage
        self.id = id
    }
}
