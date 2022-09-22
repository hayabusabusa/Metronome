//
//  MetronomeControlButton.swift
//  
//
//  Created by Shunya Yamada on 2022/09/22.
//

import UIKit

final class MetronomeControlButton: UIButton {
    private let highlightedColor = UIColor.gray.withAlphaComponent(0.3)
    private(set) var size = CGSize(width: 80, height: 80)

    // MARK: Subviews

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: Lifecycle

    init(size: CGSize) {
        super.init(frame: .zero)
        self.size = size
        configure()
    }

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

// MARK: - Configurations

private extension MetronomeControlButton {
    func configure() {
        clipsToBounds = true
        layer.cornerRadius = size.width / 2.0
        setBackgroundImage(highlightedColor.image(), for: .highlighted)

        addSubview(iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: size.height / 2.0),
            iconImageView.widthAnchor.constraint(equalToConstant: size.width / 2.0)
        ])
    }
}

// MARK: - Extensions

private extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { context in
            self.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
    }
}
