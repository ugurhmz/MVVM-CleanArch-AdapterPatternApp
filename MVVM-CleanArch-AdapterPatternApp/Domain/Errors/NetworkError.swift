//
//  NetworkError.swift
//  MVVM-CleanArch-AdapterPatternApp
//
//  Created by rico on 29.12.2025.
//

import Foundation

enum NetworkError: Error, Sendable {
    case decode               // JSON parçalanamadı
    case invalidURL           // URL bozuk
    case serverError(code: Int) // 404, 500 vb. hatalar
    case unknown(String)      // Beklenmeyen durumlar
    
    var localizedDescription: String {
        switch self {
        case .decode: return "Veri modeli işlenemedi."
        case .invalidURL: return "Geçersiz URL."
        case .serverError(let code): return "Sunucu hatası: \(code)"
        case .unknown(let msg): return "Bilinmeyen hata: \(msg)"
        }
    }
}
