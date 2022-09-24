//
//  RecordingWaveformCell.swift
//  
//
//  Created by Shunya Yamada on 2022/09/24.
//

import UIKit

final class RecordingWaveformCell: UICollectionViewCell {

    // MARK: Subviews

    private lazy var waveView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var waveViewHeightConstraint: NSLayoutConstraint?

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func configure(with height: CGFloat) {
        waveViewHeightConstraint?.constant = height
        layoutIfNeeded()
    }
}

private extension RecordingWaveformCell {
    func configure() {
        addSubview(waveView)

        let waveViewHeightConstraint = waveView.heightAnchor.constraint(equalToConstant: 24)
        self.waveViewHeightConstraint = waveViewHeightConstraint
        NSLayoutConstraint.activate([
            waveView.trailingAnchor.constraint(equalTo: trailingAnchor),
            waveView.leadingAnchor.constraint(equalTo: leadingAnchor),
            waveView.centerYAnchor.constraint(equalTo: centerYAnchor),
            waveViewHeightConstraint
        ])
    }
}
