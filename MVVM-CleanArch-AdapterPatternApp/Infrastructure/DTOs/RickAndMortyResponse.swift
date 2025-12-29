//
//  RickAndMortyResponse.swift
//  MVVM-CleanArch-AdapterPatternApp
//
//  Created by rico on 29.12.2025.
//

import Foundation

struct RickAndMortyResponse: Decodable, Sendable {
    let info: Info
    let results: [Character]
}

struct Info: Decodable, Sendable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
