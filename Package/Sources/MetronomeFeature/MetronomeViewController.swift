//
//  MetronomeViewController.swift
//  
//
//  Created by Shunya Yamada on 2022/09/22.
//

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
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("START", for: .normal)
        return button
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
