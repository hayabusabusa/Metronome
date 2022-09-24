//
//  RecordingWaveformCollectionViewControllerPreview.swift
//  
//
//  Created by Shunya Yamada on 2022/09/24.
//

@testable import RecordingFeature
import SwiftUI

private extension RecordingWaveformCollectionViewController {
    struct Wrapped: UIViewControllerRepresentable {
        typealias UIViewControllerType = RecordingWaveformCollectionViewController

        func makeUIViewController(context: Context) -> RecordingWaveformCollectionViewController {
            let vc = RecordingWaveformCollectionViewController()
            return vc
        }

        func updateUIViewController(_ uiViewController: RecordingWaveformCollectionViewController, context: Context) {

        }
    }
}

struct RecordingWaveformCollectionViewController__Preview: PreviewProvider {
    static var previews: some View {
        RecordingWaveformCollectionViewController.Wrapped()
    }
}
