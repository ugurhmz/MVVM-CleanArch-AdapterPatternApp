//
//  HomeViewController.swift
//  MVVM-CleanArch-AdapterPatternApp
//
//  Created by rico on 29.12.2025.
//

import UIKit

final class HomeViewController: UIViewController {
    private let viewModel: HomeViewModelProtocol
    
    init(viewModel: HomeViewModelProtocol) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        
            self.viewModel.delegate = self
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
    }
}

// MARK: -
extension HomeViewController: HomeViewModelDelegate {
    
    func didChangeState(to state: HomeViewState) {
        switch state {
        case .loading:
            print("Loading State UI Updates...")
            
        case .success:
            print("Success State UI Updates")
            print("Fetched: \(viewModel.characters.count) items")
            
        case .failure(let message):
            print("Failure State UI Updates: \(message)")
        }
    }
}
