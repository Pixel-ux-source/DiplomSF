//
//  MovieImagesMapping.swift
//  DiplomSF
//
//  Created by Алексей on 21.10.2025.
//

import Foundation

struct MovieImagesMapping {
    static func mapping(from model: MovieImagesResponse) -> [String] {
        model.backdrops.filter { $0.iso3166_1 == nil }.map { "https://image.tmdb.org/t/p/w500\($0.filePath)" }
    }
}
