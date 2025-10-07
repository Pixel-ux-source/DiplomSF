//
//  APIEndpoint.swift
//  DiplomSF
//
//  Created by Алексей on 02.09.2025.
//

import Foundation
import Alamofire

enum APIEndpoint {
    private static let baseURLString = "https://api.themoviedb.org/3"
    
    case getPopular(language: String, page: Int)
    
    var url: URL? {
        switch self {
        case .getPopular:
            return URL(string: "\(APIEndpoint.baseURLString)/movie/popular")
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .getPopular:
            return [
                "Authorization":"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhN2QwNGIwMWUyOWYyOTI1MTcwNmZlOTQ3YjhjNWMzZCIsIm5iZiI6MTc1NjgwMjMyOC43OTksInN1YiI6IjY4YjZhZDE4MjhjYjFjNmI5ZTE1ODhiNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.bPJBTkZhNnnJsLODUTefq--yrcFP9mX7UDto6xFZFvI"
            ]
        }
    }
    
    // Можно добавить переключатель языка в профиле после auth. Но тогда нужно каждый раз делать новый запрос.
    var params: Parameters {
        switch self {
        case .getPopular(let language, let page):
            return [
                "language":language,
                "page":page
            ]
        }
    }
}
