//
//  NetworlProtocol.swift
//  DiplomSF
//
//  Created by Алексей on 02.09.2025.
//

import Foundation
import Alamofire

protocol NetworkProtocol: AnyObject {
    func get<T:Decodable>(of type: T.Type, endpoint: APIEndpoint, method: HTTPMethod, parameters: Alamofire.Parameters?, headers: Alamofire.HTTPHeaders?, completion: @escaping (Result<T, Error>) -> Void)
}
