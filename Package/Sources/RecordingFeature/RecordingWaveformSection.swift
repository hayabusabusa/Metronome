//
//  RecordingWaveformSection.swift
//  
//
//  Created by Shunya Yamada on 2022/09/24.
//

import UIKit

enum RecordingWaveformSection: Hashable {
    case scale

    func layout(with environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        switch self {
        case .scale:
            let horizontalInset = environment.container.contentSize.width / 2.0
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(1), heightDimension: .fractionalHeight(1))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = 4.0
            section.contentInsets = .init(top: 0, leading: horizontalInset, bottom: 0, trailing: horizontalInset)
            return section
        }
    }
}

enum RecordingWaveformItem: Hashable {
    case scale(index: Int, height: CGFloat)

    func cell(_ collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionViewCell {
        switch self {
        case let .scale(_, height):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RecordingWaveformCell.self), for: indexPath) as! RecordingWaveformCell
            cell.configure(with: height)
            return cell
        }
    }
}
