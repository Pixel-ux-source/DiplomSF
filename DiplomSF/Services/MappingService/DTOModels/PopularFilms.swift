//
//  PopularFilms.swift
//  DiplomSF
//
//  Created by Алексей on 02.09.2025.
//

import Foundation
import CoreData

protocol IdentifiableDTO: Decodable {
    var id: Int { get }
}

struct PopularFilms: Decodable {
    let page: Int32
    let results: [Film]
    let totalPages: Int64
    let totalResults: Int64
}

struct Film: IdentifiableDTO {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}

extension Films: MappableProtocol {
    func map(in context: NSManagedObjectContext) throws -> [Popular] {
        PopularMapping.map(from: self, context: context)
    }
    
    typealias Entity = Popular
}
