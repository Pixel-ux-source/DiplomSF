//
//  NetworkError.swift
//  DiplomSF
//
//  Created by Алексей on 02.09.2025.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case serverError(Int)
    case clientError(Int)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Неверный URL"
        case .serverError(let code):
            return "Сервер вернул ошибку \(code)"
        case .clientError(let code):
            return "Клиент вернул ошибку \(code)"
        case .unknown:
            return "Неизвестная ошибка"
        }
    }
}
