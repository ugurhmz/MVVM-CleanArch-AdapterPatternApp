//
//  AlamofireNetworkAdapter.swift
//  MVVM-CleanArch-AdapterPatternApp
//
//  Created by rico on 29.12.2025.
//

import Foundation
import Alamofire

final class AlamofireNetworkAdapter: NetworkServiceProtocol {
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: EndpointContract, model: T.Type) async throws -> T {
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
            throw NetworkError.invalidURL
        }
        
        let method = HTTPMethod(rawValue: endpoint.method.rawValue)
        let encoding: ParameterEncoding
        
        switch endpoint.encoding {
        case .url:
            encoding = URLEncoding.default
        case .json:
            encoding = URLEncoding.default
        }
        
        let task = session.request(
            url,
            method: method,
            parameters: endpoint.body,
            encoding: encoding,
            headers: HTTPHeaders(endpoint.headers ?? [:]),
        ).serializingDecodable(model)
        
        let response = await task.response
        
        switch response.result {
        case .success(let data):
            return data
        case .failure(let error):
            if let statusCode = error.responseCode {
                throw NetworkError.serverError(code: statusCode)
            } else {
                throw NetworkError.unknown(error.localizedDescription)
            }
        }
    }
}
