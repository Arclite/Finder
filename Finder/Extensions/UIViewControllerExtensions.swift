//  Created by Geoff Pado on 4/7/18.
//  Copyright © 2018 Cocoatype, LLC. All rights reserved.

import UIKit

extension UIViewController {
    static func notImplementedInit() -> Never {
        fatalError("\(String(describing: type(of: self))) does not implement init(coder:)")
    }

    func embed(_ newChild: UIViewController) {
        if let existingChild = childViewControllers.first {
            existingChild.willMove(toParentViewController: nil)
            existingChild.view.removeFromSuperview()
            existingChild.removeFromParentViewController()
        }

        guard let newChildView = newChild.view else { return }
        newChildView.translatesAutoresizingMaskIntoConstraints = false

        addChildViewController(newChild)
        view.addSubview(newChildView)
        newChild.didMove(toParentViewController: self)

        NSLayoutConstraint.activate([
            newChildView.widthAnchor.constraint(equalTo: view.widthAnchor),
            newChildView.heightAnchor.constraint(equalTo: view.heightAnchor),
            newChildView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newChildView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func transition(to newChild: UIViewController) {
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: { [unowned self] in self.embed(newChild) }, completion: nil)
    }
}
