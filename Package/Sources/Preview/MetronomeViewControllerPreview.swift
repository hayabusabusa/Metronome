//
//  MetronomeViewControllerPreview.swift
//  
//
//  Created by Shunya Yamada on 2022/09/22.
//

import SwiftUI
import MetronomeFeature

private extension MetronomeViewController {
    struct Wrapped: UIViewControllerRepresentable {
        typealias UIViewControllerType = MetronomeViewController

        func makeUIViewController(context: Context) -> MetronomeViewController {
            let vc = MetronomeViewController()
            return vc
        }

        func updateUIViewController(_ uiViewController: MetronomeViewController, context: Context) {
        }
    }
}

struct MetronomeViewControllerPreview: PreviewProvider {
    static var previews: some View {
        MetronomeViewController.Wrapped()
    }
}
