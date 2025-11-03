//
//  MovieImagesResponse.swift
//  DiplomSF
//
//  Created by Алексей on 21.10.2025.
//

import Foundation

struct MovieImagesResponse: Codable {
    let backdrops: [Backdrop]
}

struct Backdrop: Codable {
    let aspectRatio: Double
    let height: Int
    let iso3166_1: String?
    let iso639_1: String?
    let filePath: String
    let voteAverage: Double
    let voteCount: Int
    let width: Int
}
