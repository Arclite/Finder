//  Created by Geoff Pado on 4/8/18.
//  Copyright © 2018 Cocoatype, LLC. All rights reserved.

import UIKit

class LoginActivityViewController: UIViewController {
    var onLogin: ((Bool, Error?) -> Void)?

    init(appleID: String, password: String) {
        self.appleID = appleID
        self.password = password
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white

        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let loginOperation = LoginOperation(appleID: appleID, password: password)
        loginOperation.completionBlock = { [weak self, weak loginOperation] in
            guard let serviceURL = loginOperation?.serviceURL else {
                self?.onLogin?(false, loginOperation?.error)
                return
            }

            UserDefaults.suite.set(serviceURL, forKey: DefaultsKeys.serviceURL)
            self?.onLogin?(true, loginOperation?.error)
        }
        operationQueue.addOperation(loginOperation)
    }

    // MARK: Boilerplate

    private let appleID: String
    private let password: String

    private let operationQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.qualityOfService = .userInitiated
        return operationQueue
    }()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        type(of: self).notImplementedInit()
    }
}
