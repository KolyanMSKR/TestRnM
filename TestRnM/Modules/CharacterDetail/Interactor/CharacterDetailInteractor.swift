//
//  CharacterDetailInteractor.swift
//  TestRnM
//
//  Created by Anderen on 01.04.2025.
//

import Foundation

final class CharacterDetailInteractor: CharacterDetailBusinessLogic {

    private let presenter: CharacterDetailPresentationLogic
    private let character: Character

    init(
        presenter: CharacterDetailPresentationLogic,
        character: Character
    ) {
        self.presenter = presenter
        self.character = character
    }

    func viewDidLoad() {
        presenter.presentCharacterDetails(character: character)
    }

}
