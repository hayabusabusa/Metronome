//
//  RecordingViewController.swift
//  
//
//  Created by Shunya Yamada on 2022/09/24.
//

import Shared
import UIKit

public final class RecordingViewController: UIViewController {

    // MARK: Subviews

    private lazy var controlsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00.00"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 24
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var playButton: AudioControlButton = {
        let button = AudioControlButton(size: .init(width: 80, height: 80))
        let action = UIAction { [weak self] _ in

        }
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(action, for: .touchUpInside)
        button.setIcon(UIImage(systemName: "play.fill"))
        return button
    }()

    private lazy var increaseButton: AudioControlButton = {
        let button = AudioControlButton(size: .init(width: 56, height: 56))
        let action = UIAction { [weak self] _ in

        }
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setIcon(UIImage(systemName: "goforward.15"))
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    private lazy var decreaseButton: AudioControlButton = {
        let button = AudioControlButton(size: .init(width: 56, height: 56))
        let action = UIAction { [weak self] _ in

        }
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setIcon(UIImage(systemName: "gobackward.15"))
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    private lazy var recordingButton: RecordingButton = {
        let button = RecordingButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        button.setTitle("録音開始", for: .normal)
        return button
    }()

    // MARK: Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
}

// MARK: - Configurations

private extension RecordingViewController {
    func configureSubviews() {
        view.backgroundColor = .systemBackground
        view.addSubview(controlsStackView)

        controlsStackView.addArrangedSubview(timeLabel)
        controlsStackView.addArrangedSubview(buttonsStackView)
        controlsStackView.addArrangedSubview(recordingButton)
        buttonsStackView.addArrangedSubview(decreaseButton)
        buttonsStackView.addArrangedSubview(playButton)
        buttonsStackView.addArrangedSubview(increaseButton)

        NSLayoutConstraint.activate([
            controlsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            controlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            decreaseButton.heightAnchor.constraint(equalToConstant: decreaseButton.size.height),
            decreaseButton.heightAnchor.constraint(equalToConstant: decreaseButton.size.width),
            playButton.heightAnchor.constraint(equalToConstant: playButton.size.height),
            playButton.widthAnchor.constraint(equalToConstant: playButton.size.width),
            playButton.centerXAnchor.constraint(equalTo: buttonsStackView.centerXAnchor),
            increaseButton.heightAnchor.constraint(equalToConstant: increaseButton.size.height),
            increaseButton.widthAnchor.constraint(equalToConstant: increaseButton.size.width),
            recordingButton.heightAnchor.constraint(equalToConstant: RecordingButton.height),
            recordingButton.widthAnchor.constraint(equalToConstant: 128),
        ])
    }
}
