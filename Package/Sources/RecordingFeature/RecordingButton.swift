//
//  RecordingButton.swift
//  
//
//  Created by Shunya Yamada on 2022/09/24.
//

import UIKit

final class RecordingButton: UIButton {

    static let height: CGFloat = 40.0
    private static let spacing: CGFloat = 4.0

    // MARK: Subviews

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var outlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor.label.cgColor
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func setIcon(_ image: UIImage?) {
        iconImageView.image = image
    }
}

private extension RecordingButton {
    func configure() {
        layer.cornerRadius = Self.height / 2.0
        outlineView.layer.cornerRadius = (Self.height + Self.spacing) / 2.0

        addSubview(outlineView)
        addSubview(iconImageView)
        NSLayoutConstraint.activate([
            outlineView.topAnchor.constraint(equalTo: topAnchor, constant: -Self.spacing),
            outlineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Self.spacing),
            outlineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Self.spacing),
            outlineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -Self.spacing),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: Self.height / 2.0),
        ])
    }
}
