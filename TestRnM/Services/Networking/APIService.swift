//
//  APIService.swift
//  TestRnM
//
//  Created by Anderen on 03.04.2025.
//

import Foundation
import Moya

protocol CharacterServiceProtocol {
    func fetchCharacters(page: Int, completion: @escaping (Result<CharacterResponse, Error>) -> Void)
}

final class CharacterService: CharacterServiceProtocol {
    private let provider: MoyaProvider<RickAndMortyAPI>

    init(provider: MoyaProvider<RickAndMortyAPI> = MoyaProvider<RickAndMortyAPI>()) {
        self.provider = provider
    }

    func fetchCharacters(page: Int, completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
        provider.request(.characters(page: page)) { result in
            switch result {
            case let .success(response):
                do {
                    let decodedData = try JSONDecoder().decode(CharacterResponse.self, from: response.data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
