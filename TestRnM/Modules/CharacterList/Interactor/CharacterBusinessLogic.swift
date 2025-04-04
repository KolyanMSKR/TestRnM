//
//  CharacterBusinessLogic.swift
//  TestRnM
//
//  Created by Anderen on 02.04.2025.
//

import Foundation

protocol CharacterBusinessLogic {
    func fetchCharacters()
    func didSelectCharacter(at index: Int)
}

protocol CharacterDataStore {
    var characters: [Character] { get set }
}
