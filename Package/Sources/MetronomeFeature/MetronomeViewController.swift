//
//  MetronomeViewController.swift
//  
//
//  Created by Shunya Yamada on 2022/09/22.
//

import Audio
import UIKit

public final class MetronomeViewController: UIViewController {

    // MARK: Subviews

    private lazy var bpmLabel: UILabel = {
        let label = UILabel()
        label.text = "120"
        label.font = .systemFont(ofSize: 64, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("TAP", for: .normal)
        button.addAction(buttonAction, for: .touchUpInside)
        return button
    }()

    private lazy var buttonAction: UIAction = {
        UIAction { [weak self] _ in
            if self?.hapticService?.isPlaying == false {
                try? self?.hapticService?.play()
            } else {
                self?.hapticService?.stop()
            }
        }
    }()

    // MARK: Properties

    private lazy var hapticService: HapticService? = {
        try? HapticService()
    }()

    // MARK: Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
}

// MARK: - Configurations

private extension MetronomeViewController {
    func configureSubviews() {
        view.backgroundColor = .systemBackground
        view.addSubview(bpmLabel)
        view.addSubview(button)

        NSLayoutConstraint.activate([
            bpmLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 56),
            bpmLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
