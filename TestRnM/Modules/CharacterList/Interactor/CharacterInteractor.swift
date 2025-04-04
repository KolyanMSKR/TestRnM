//
//  CharacterInteractor.swift
//  TestRnM
//
//  Created by Anderen on 01.04.2025.
//

import CoreData
import Foundation

final class CharacterInteractor: CharacterBusinessLogic, CharacterDataStore {

    private enum ReacabilityError: Error, LocalizedError {
        case noInternetConnection

        public var errorDescription: String? {
            switch self {
            case .noInternetConnection:
                return "No internet connection. Data loaded from a local storage"
            }
        }
    }

    var router: CharacterRoutingLogic?
    var characters: [Character] = []

    private let presenter: CharacterPresentationLogic
    private var characterService: CharacterServiceProtocol
    private var reachability: NetworkReachabilityProtocol
    private let characterCoreDataWorker: CharacterCoreDataWorkerProtocol
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    private var isLoading: Bool = false

    init(
        presenter: CharacterPresentationLogic,
        apiService: CharacterServiceProtocol = CharacterService(),
        reachability: NetworkReachabilityProtocol = NetworkReachabilityManager(),
        characterCoreDataWorker: CharacterCoreDataWorkerProtocol
    ) {
        self.presenter = presenter
        self.characterService = apiService
        self.reachability = reachability
        self.characterCoreDataWorker = characterCoreDataWorker
    }

    func fetchCharacters() {
        if !reachability.isNetworkAvailable {
            presenter.presentError(error: ReacabilityError.noInternetConnection)

            characterCoreDataWorker.loadFromCoreData { [weak self] charactersFromCoreData in
                guard let self else { return }
                self.characters = charactersFromCoreData
                self.presenter.presentCharacters(characters: self.characters)
            }
        } else {
            guard !isLoading, currentPage <= totalPages else { return }

            isLoading = true
            
            characterService.fetchCharacters(page: currentPage) { [weak self] result in
                guard let self else { return }
                self.isLoading = false

                switch result {
                case .success(let characterResponse):
                    self.characters.append(contentsOf: characterResponse.results)
                    self.totalPages = characterResponse.info.pages
                    self.currentPage += 1
                    DispatchQueue.main.async {
                        self.presenter.presentCharacters(characters: self.characters)
                    }
                    characterCoreDataWorker.saveToCoreData(characters: characterResponse.results)
                case .failure(let error):
                    self.presenter.presentError(error: error)
                }
            }
        }
    }

    func didSelectCharacter(at index: Int) {
        let selectedCharacter = characters[index]
        router?.routeToDetailScreen(with: selectedCharacter)
    }

}







