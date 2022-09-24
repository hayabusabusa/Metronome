//
//  UIViewController+.swift
//  
//
//  Created by Shunya Yamada on 2022/09/25.
//

import UIKit

public extension UIViewController {
    func embed(in viewController: UIViewController) {
        embed(in: viewController.view, on: viewController)
    }

    func embed(in view: UIView, on viewController: UIViewController) {
        view.addSubview(self.view)
        viewController.addChild(self)
        didMove(toParent: viewController)

        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: view.topAnchor),
            self.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.view.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}
