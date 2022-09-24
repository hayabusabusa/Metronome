//
//  RecordingViewControllerPreview.swift
//  
//
//  Created by Shunya Yamada on 2022/09/24.
//

import RecordingFeature
import SwiftUI

private extension RecordingViewController {
    struct Wrapped: UIViewControllerRepresentable {
        typealias UIViewControllerType = RecordingViewController

        func makeUIViewController(context: Context) -> RecordingViewController {
            return RecordingViewController()
        }

        func updateUIViewController(_ uiViewController: RecordingViewController, context: Context) {

        }
    }
}

struct RecordingViewController__Preview: PreviewProvider {
    static var previews: some View {
        RecordingViewController.Wrapped()
    }
}
