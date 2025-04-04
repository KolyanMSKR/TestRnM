//
//  CharacterPresenter.swift
//  TestRnM
//
//  Created by Anderen on 01.04.2025.
//

import Foundation

final class CharacterPresenter: CharacterPresentationLogic {
    
    weak var viewController: CharacterDisplayLogic?

    func presentCharacters(characters: [Character]) {
        let viewModel = CharacterViewModel(characters: characters)
        viewController?.displayCharacters(viewModel: viewModel)
    }

    func presentError(error: Error) {
        viewController?.displayError(error: error)
    }

}

