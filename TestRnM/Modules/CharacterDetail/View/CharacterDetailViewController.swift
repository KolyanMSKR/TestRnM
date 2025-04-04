//
//  CharacterDetailViewController.swift
//  TestRnM
//
//  Created by Anderen on 01.04.2025.
//

import UIKit

final class CharacterDetailViewController: UIViewController, CharacterDetailDisplayLogic {

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    private lazy var speciesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, speciesLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let interactor: CharacterDetailBusinessLogic

    init(interactor: CharacterDetailBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        interactor.viewDidLoad()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(labelsStackView)

        setupConstraintsForPortrait()
    }

    private func setupConstraintsForPortrait() {
        NSLayoutConstraint.deactivate(view.constraints)

        let screenWidth = view.bounds.width
        let imageHeight = screenWidth * 0.8

        let imageWidth = imageHeight

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            imageView.widthAnchor.constraint(equalToConstant: imageWidth),
            imageView.heightAnchor.constraint(equalToConstant: imageHeight),

            labelsStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            labelsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    private func setupConstraintsForLandscape() {
        NSLayoutConstraint.deactivate(view.constraints)

        let screenHeight = view.bounds.height
        let imageHeight = screenHeight * 0.8

        let imageWidth = imageHeight

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageWidth),
            imageView.heightAnchor.constraint(equalToConstant: imageHeight),

            labelsStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            labelsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        if size.width > size.height {
            setupConstraintsForLandscape()
        } else {
            setupConstraintsForPortrait()
        }
    }

    func displayCharacterDetails(viewModel: CharacterDetailViewModel) {
        nameLabel.text = viewModel.name
        speciesLabel.text = "Species: \(viewModel.species)"
        if let imageURL = URL(string: viewModel.imageURL) {
            imageView.setImage(with: imageURL)
        }
    }
}
