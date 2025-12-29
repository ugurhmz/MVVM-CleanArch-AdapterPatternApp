//
//  HomeViewModel.swift
//  MVVM-CleanArch-AdapterPatternApp
//
//  Created by rico on 29.12.2025.
//

import Foundation

enum HomeViewState: Sendable {
    case loading
    case success
    case failure(String)
}

@MainActor
protocol HomeViewModelDelegate: AnyObject {
    func didChangeState(to state: HomeViewState)
}

@MainActor
protocol HomeViewModelProtocol: AnyObject {
    var delegate: HomeViewModelDelegate? { get set }
    var characters: [Character] { get }
    
    func fetchCharacters()
}

// MARK: -
@MainActor
final class HomeViewModel: HomeViewModelProtocol {
    private let networkService: NetworkServiceProtocol
    var characters: [Character] = []
    
    weak var delegate: HomeViewModelDelegate?
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchCharacters() {
        delegate?.didChangeState(to: .loading)
        
        Task {
            do {
                let response = try await networkService.request(RickAndMortyEndpoint.getCharacters, model: RickAndMortyResponse.self)
                self.characters = response.results
                delegate?.didChangeState(to: .success)
            } catch {
                delegate?.didChangeState(to: .failure(error.localizedDescription))
            }
        }
    }
}
