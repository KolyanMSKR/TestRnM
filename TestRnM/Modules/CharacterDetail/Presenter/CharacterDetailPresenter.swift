//
//  CharacterDetailPresenter.swift
//  TestRnM
//
//  Created by Anderen on 01.04.2025.
//

import Foundation

final class CharacterDetailPresenter: CharacterDetailPresentationLogic {

    weak var viewController: CharacterDetailDisplayLogic?

    func presentCharacterDetails(character: Character) {
        let viewModel = CharacterDetailViewModel(name: character.name, species: character.species, imageURL: character.image)
        viewController?.displayCharacterDetails(viewModel: viewModel)
    }

}
