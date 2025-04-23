//
//  CharacterDetailRouter.swift
//  TestRnM
//
//  Created by Anderen on 01.04.2025.
//

import UIKit

final class CharacterDetailRouter: CharacterDetailRoutingLogic {

    weak var viewController: UIViewController?

    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }

}
