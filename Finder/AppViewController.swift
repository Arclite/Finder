//  Created by Geoff Pado on 4/6/18.
//  Copyright © 2018 Cocoatype, LLC. All rights reserved.

import os.log
import UIKit

class AppViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        super.loadView()
        embed(initialViewController)
    }

    private func performLogin(withAppleID appleID: String, password: String) {
        let activityViewController = LoginActivityViewController(appleID: appleID, password: password)
        activityViewController.onLogin = { [weak self] success, error in
            guard let appViewController = self else { return }

            switch success {
            case true:
                fatalError("success")
            case false:
                DispatchQueue.main.async {
                    let loginViewController = appViewController.newLoginFormViewController()
                    appViewController.transition(to: loginViewController)
                }
            }
        }
        transition(to: activityViewController)
    }

    // MARK: Boilerplate

    lazy var initialViewController: UIViewController = {
        return newLoginFormViewController()
    }()

    private func newLoginFormViewController() -> LoginFormViewController {
        let loginViewController = LoginFormViewController()
        loginViewController.submitAction = { [weak self] appleID, password in
            self?.performLogin(withAppleID: appleID, password: password)
        }

        return loginViewController
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        type(of: self).notImplementedInit()
    }
}
