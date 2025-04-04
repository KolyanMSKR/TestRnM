//
//  CharacterViewController.swift
//  TestRnM
//
//  Created by Anderen on 01.04.2025.
//

import UIKit

final class CharacterViewController: UIViewController {

    var interactor: CharacterBusinessLogic
    var characters: [Character] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private let tableView = UITableView()

    init(
        interactor: CharacterBusinessLogic
    ) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        interactor.fetchCharacters()
    }

}

// MARK: - CharacterDisplayLogic extension

extension CharacterViewController: CharacterDisplayLogic {

    func displayCharacters(viewModel: CharacterViewModel) {
        characters = viewModel.characters
    }

    func displayError(error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)

        alertController.addAction(okAction)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let viewController = windowScene.windows.first(where: \.isKeyWindow)?.rootViewController {
                viewController.present(alertController, animated: true, completion: nil)
            }
        }
    }

}

// MARK: - Private extension

private extension CharacterViewController {

    func setupUI() {
        view.backgroundColor = .white
        setupNavigationBar()
        setupTableView()
    }

    func setupNavigationBar() {
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CharacterCell.self)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }

}

// MARK: - UITableViewDataSource

extension CharacterViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CharacterCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let character = characters[indexPath.row]
        let characterCellViewModel = CharacterCellViewModel(
            name: character.name,
            imageURL: character.image,
            status: character.status.rawValue
        )
        cell.configure(with: characterCellViewModel)
        return cell
    }

}

// MARK: - UITableViewDelegate

extension CharacterViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.didSelectCharacter(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let contentOffsetY = scrollView.contentOffset.y
        let height = scrollView.frame.size.height

        if contentOffsetY + height > contentHeight - 100 {
            interactor.fetchCharacters()
        }
    }
}
