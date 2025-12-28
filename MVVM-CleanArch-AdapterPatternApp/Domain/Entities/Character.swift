//
//  Character.swift
//  MVVM-CleanArch-AdapterPatternApp
//
//  Created by rico on 29.12.2025.
//

import Foundation

struct Character: Decodable, Sendable {
    let id: Int
    let name: String?
    let status: String?
    let species: String?
}
