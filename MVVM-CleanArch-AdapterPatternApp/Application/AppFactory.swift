//
//  AppFactory.swift
//  MVVM-CleanArch-AdapterPatternApp
//
//  Created by rico on 29.12.2025.
//

import UIKit

@MainActor
final class HomeBuilder {
    
    static func build() -> UIViewController {
        let networkService = AlamofireNetworkAdapter()
        let viewModel = HomeViewModel(networkService: networkService)
        let viewController = HomeViewController(viewModel: viewModel)
        
        return viewController
    }
}
