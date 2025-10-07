//
//  PopularMapping.swift
//  DiplomSF
//
//  Created by Алексей on 02.09.2025.
//

import Foundation
import CoreData

struct PopularMapping: MappingProtocol {
    static func map(from model: Films, context: NSManagedObjectContext) -> [Popular] {
        return model.map { filmDTO in
            let popularFilmObject = Popular(context: context)
            
            popularFilmObject.id = Int64(filmDTO.id)
            popularFilmObject.originalTitle = filmDTO.originalTitle
            popularFilmObject.title = filmDTO.title
            popularFilmObject.posterPath = filmDTO.posterPath
            popularFilmObject.releaseDate = filmDTO.releaseDate
            popularFilmObject.overview = filmDTO.overview
            popularFilmObject.voteAverage = filmDTO.voteAverage
            popularFilmObject.backdropPath = filmDTO.backdropPath
            
            return popularFilmObject
        }
    }
    
    typealias Entity = Popular
    
    typealias DTO = Films
}

typealias Films = [Film]
