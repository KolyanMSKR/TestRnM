//
//  CharacterRouter.swift
//  TestRnM
//
//  Created by Anderen on 04.04.2025.
//

import UIKit

final class CharacterRouter: CharacterRoutingLogic {

    weak var viewController: UIViewController?
    var window: UIWindow?

    func start(with windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)

        let apiService: CharacterServiceProtocol = CharacterService()
        let reachability: NetworkReachabilityProtocol = NetworkReachabilityManager()
        let characterCoreDataWorker = CharacterCoreDataWorker()

        let presenter = CharacterPresenter()
        let interactor = CharacterInteractor(
            presenter: presenter,
            apiService: apiService,
            reachability: reachability,
            characterCoreDataWorker: characterCoreDataWorker
        )
        let characterViewContoller = CharacterViewController(interactor: interactor)

        presenter.viewController = characterViewContoller
        interactor.router = self
        self.viewController = characterViewContoller

        let navigationController = UINavigationController(rootViewController: characterViewContoller)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }

    func routeToDetailScreen(with character: Character) {
        let presenter = CharacterDetailPresenter()
        let interactor = CharacterDetailInteractor(presenter: presenter, character: character)
        let detailViewController = CharacterDetailViewController(interactor: interactor)
        presenter.viewController = detailViewController

        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}
