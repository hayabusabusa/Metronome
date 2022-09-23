//
//  MetronomeViewController.swift
//  
//
//  Created by Shunya Yamada on 2022/09/22.
//

import Audio
import Combine
import UIKit

public final class MetronomeViewController: UIViewController {

    // MARK: Subviews

    private lazy var controlsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var bpmLabel: UILabel = {
        let label = UILabel()
        label.text = "120"
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

    private lazy var playButton: MetronomeControlButton = {
        let button = MetronomeControlButton(frame: .zero)
        let action = UIAction { [weak self] _ in
            self?.viewModel.onPlayButtonPressed()
        }
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    private lazy var increaseButton: MetronomeControlButton = {
        let button = MetronomeControlButton(size: .init(width: 56, height: 56))
        let action = UIAction { [weak self] _ in
            self?.viewModel.onIncreaseButtonPressed()
        }
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setIcon(UIImage(systemName: "plus.circle"))
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    private lazy var decreaseButton: MetronomeControlButton = {
        let button = MetronomeControlButton(size: .init(width: 56, height: 56))
        let action = UIAction { [weak self] _ in
            self?.viewModel.onDecreaseButtonPressed()
        }
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setIcon(UIImage(systemName: "minus.circle"))
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    // MARK: Properties

    private let viewModel: MetronomeViewModel
    private var subscriptions = Set<AnyCancellable>()

    // MARK: Lifecycle

    public init(viewModel: MetronomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureSubscriptions()
    }
}

// MARK: - Configurations

private extension MetronomeViewController {
    func configureSubviews() {
        view.backgroundColor = .systemBackground
        view.addSubview(controlsStackView)

        controlsStackView.addArrangedSubview(bpmLabel)
        controlsStackView.addArrangedSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(decreaseButton)
        buttonsStackView.addArrangedSubview(playButton)
        buttonsStackView.addArrangedSubview(increaseButton)

        NSLayoutConstraint.activate([
            controlsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            controlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            decreaseButton.heightAnchor.constraint(equalToConstant: decreaseButton.size.height),
            decreaseButton.heightAnchor.constraint(equalToConstant: decreaseButton.size.width),
            playButton.heightAnchor.constraint(equalToConstant: playButton.size.height),
            playButton.widthAnchor.constraint(equalToConstant: playButton.size.width),
            playButton.centerXAnchor.constraint(equalTo: buttonsStackView.centerXAnchor),
            increaseButton.heightAnchor.constraint(equalToConstant: increaseButton.size.height),
            increaseButton.widthAnchor.constraint(equalToConstant: increaseButton.size.width)
        ])
    }

    func configureSubscriptions() {
        viewModel.$bpm
            .receive(on: DispatchQueue.main)
            .map { "\($0)" }
            .assign(to: \.text, on: bpmLabel)
            .store(in: &subscriptions)
        viewModel.$isPlaying
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.playButton.setIcon(value ? UIImage(systemName: "pause.fill") : UIImage(systemName: "play.fill"))
            }
            .store(in: &subscriptions)
    }
}
