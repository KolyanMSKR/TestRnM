//
//  CharacterCell.swift
//  TestRnM
//
//  Created by Anderen on 02.04.2025.
//

import UIKit

final class CharacterCell: UITableViewCell, ReusableView {

    private lazy var imageTitleView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private lazy var titleLabel = UILabel()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, statusLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageTitleView.cancelDownloadTask()
        imageTitleView.image = nil
        titleLabel.text = nil
        statusLabel.text = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.cornerRadius = 20
    }

    func configure(with viewModel: CharacterCellViewModel) {
        let imageURL = URL(string: viewModel.imageURL)
        imageTitleView.setImage(with: imageURL)

        titleLabel.text = viewModel.name
        statusLabel.text = "Status: \(viewModel.status)"
    }

}

// MARK: - Private extension

private extension CharacterCell {

    func setupViews() {
        contentView.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor

        contentView.addSubview(imageTitleView)
        contentView.addSubview(containerStackView)

        setupLayout()
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            imageTitleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imageTitleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),

            imageTitleView.widthAnchor.constraint(equalToConstant: 80),
            imageTitleView.heightAnchor.constraint(equalToConstant: 80),

            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            containerStackView.leadingAnchor.constraint(equalTo: imageTitleView.trailingAnchor, constant: 12),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

}
