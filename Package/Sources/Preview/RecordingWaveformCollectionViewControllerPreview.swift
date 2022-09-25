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

        @Binding var amplitudes: [CGFloat]

        func makeUIViewController(context: Context) -> RecordingWaveformCollectionViewController {
            let vc = RecordingWaveformCollectionViewController()
            return vc
        }

        func updateUIViewController(_ uiViewController: RecordingWaveformCollectionViewController, context: Context) {
            uiViewController.apply(amplitudes: amplitudes)
        }
    }
}

struct RecordingWaveformCollectionViewController__Preview: PreviewProvider {
    @State static var amplitudes = Array(repeating: 0, count: 100).map { _ in CGFloat.random(in: 0...1) }

    static var previews: some View {
        // NOTE: viewDidLoad() が走らないと CollectionView.frame が決定しないので
        // 一度 Run しないと描画されない.
        RecordingWaveformCollectionViewController.Wrapped(amplitudes: $amplitudes)
    }
}
