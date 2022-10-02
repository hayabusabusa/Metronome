//
//  RecordingWaveformCollectionViewController.swift
//  
//
//  Created by Shunya Yamada on 2022/09/24.
//

import UIKit

final class RecordingWaveformCollectionViewController: UIViewController {

    // MARK: Subviews

    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = configureCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.alwaysBounceVertical = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RecordingWaveformCell.self,
                                forCellWithReuseIdentifier: String(describing: RecordingWaveformCell.self))
        return collectionView
    }()

    // MARK: Properties

    private lazy var dataSource: UICollectionViewDiffableDataSource<RecordingWaveformSection, RecordingWaveformItem> = {
        let dataSource = UICollectionViewDiffableDataSource<RecordingWaveformSection, RecordingWaveformItem>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            return itemIdentifier.cell(collectionView, for: indexPath)
        }
        return dataSource
    }()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }

    func apply(amplitudes: [CGFloat]) {
        var snapshot = NSDiffableDataSourceSnapshot<RecordingWaveformSection, RecordingWaveformItem>()

        let items = amplitudes.enumerated()
            .map { RecordingWaveformItem.scale(index: $0.offset, height: collectionView.frame.height * $0.element) }
        snapshot.appendSections([.scale])
        snapshot.appendItems(items, toSection: .scale)
        dataSource.apply(snapshot)
    }
}

// MARK: - Configurations

private extension RecordingWaveformCollectionViewController {
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { [weak self] section, environment in
            guard let section = self?.dataSource.snapshot().sectionIdentifiers[section] else { return nil }
            return section.layout(with: environment)
        }
    }

    func configureSubviews() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}
