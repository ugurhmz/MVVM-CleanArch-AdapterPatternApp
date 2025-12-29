//
//  RickAndMortyEndpoint.swift
//  MVVM-CleanArch-AdapterPatternApp
//
//  Created by rico on 29.12.2025.
//

import Foundation

enum RickAndMortyEndpoint: EndpointContract {
    case getCharacters
    
    var baseURL: String { "https://rickandmortyapi.com/api" }
    
    var path: String {
        switch self {
        case .getCharacters:
            return "/character"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getCharacters:
            return .get
        }
    }
    
    var encoding: RequestEncoding {
        switch self {
        case .getCharacters:
                .json
        }
    }
    
    var headers: [String: String]? { nil }
    var body: [String: Any]? { nil }
}
