//
//  NetworkServiceProtocol.swift
//  MVVM-CleanArch-AdapterPatternApp
//
//  Created by rico on 29.12.2025.
//

import Foundation

protocol NetworkServiceProtocol: Sendable {
    func request<T: Decodable>(_ endpoint: EndpointContract, model: T.Type) async throws -> T
}
