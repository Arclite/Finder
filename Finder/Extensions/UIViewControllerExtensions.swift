//  Created by Geoff Pado on 4/7/18.
//  Copyright © 2018 Cocoatype, LLC. All rights reserved.

import UIKit

extension UIViewController {
    static func notImplementedInit() -> Never {
        fatalError("\(String(describing: type(of: self))) does not implement init(coder:)")
    }

    func embed(_ newChild: UIViewController) {
        if let existingChild = childViewControllers.first {
            existingChild.view.removeFromSuperview()
            existingChild.removeFromParentViewController()
        }

        guard let newChildView = newChild.view else { return }
        newChildView.translatesAutoresizingMaskIntoConstraints = false

        addChildViewController(newChild)

        view.addSubview(newChildView)

        NSLayoutConstraint.activate([
            newChildView.widthAnchor.constraint(equalTo: view.widthAnchor),
            newChildView.heightAnchor.constraint(equalTo: view.heightAnchor),
            newChildView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newChildView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
