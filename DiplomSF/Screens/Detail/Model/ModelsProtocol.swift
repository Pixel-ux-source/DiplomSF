//
//  ModelsProtocol.swift
//  DiplomSF
//
//  Created by Алексей on 01.10.2025.
//

import Foundation

protocol ModelsProtocol {
    var id: Int64 { get }
    var originalTitle: String { get }
    var title: String { get }
    var posterPath: String { get }
    var releaseDate: String { get }
    var overview: String { get }
    var voteAverage: Double { get }
}
