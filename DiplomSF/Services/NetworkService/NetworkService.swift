//
//  NetworkService.swift
//  DiplomSF
//
//  Created by Алексей on 02.09.2025.
//

import Foundation
import Alamofire

final class NetworkService: NetworkProtocol {
    // MARK: – Request
    private func request<T>(of type: T.Type, endpoint: APIEndpoint, method: Alamofire.HTTPMethod = .get, parameters: Alamofire.Parameters? = nil, headers: Alamofire.HTTPHeaders? = nil, completion: @escaping (Result<T, any Error>) -> Void) where T : Decodable {
        
        guard let url = endpoint.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(url, method: method, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: T.self, queue: .global(qos: .background), decoder: decoder) { response in
                switch response.result {
                case .success(let value):
                    DispatchQueue.main.async {
                        completion(.success(value))
                    }
                case .failure(let error):
                    let networkError: NetworkError
                    if let statusCode = response.response?.statusCode {
                        switch statusCode {
                        case 400...499:
                            networkError = .clientError(statusCode)
                        case 500...599:
                            networkError = .serverError(statusCode)
                        default:
                            networkError = .unknown
                        }
                    } else {
                        networkError = .unknown
                    }
                                        
                    DispatchQueue.main.async {
                        completion(.failure(networkError))
                        print("LocalizedDescription – \(error.localizedDescription) \n")
                    }
                }
            }
    }
    
    // MARK: – HTTP Method's
    func get<T:Decodable>(of type: T.Type, endpoint: APIEndpoint, method: HTTPMethod = .get, parameters: Alamofire.Parameters? = nil, headers: Alamofire.HTTPHeaders? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        request(of: type, endpoint: endpoint, method: method, parameters: parameters, headers: headers, completion: completion)
    }
}
