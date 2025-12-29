//
//  EndpointContract.swift
//  MVVM-CleanArch-AdapterPatternApp
//
//  Created by rico on 29.12.2025.
//

import Foundation

enum RequestEncoding {
    case url
    case json
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

protocol EndpointContract  {
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var headers: [String: String]? { get }
    var body: [String: Any]? { get }
    
    var encoding: RequestEncoding { get }
}
