//
//  CharacterDisplayLogic.swift
//  TestRnM
//
//  Created by Anderen on 02.04.2025.
//

import Foundation

protocol CharacterDisplayLogic: AnyObject {
    func displayCharacters(viewModel: CharacterViewModel)
    func displayError(error: Error)
}
