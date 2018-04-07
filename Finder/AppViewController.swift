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

    // MARK: Boilerplate

    let initialViewController = LoginViewController()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        type(of: self).notImplementedInit()
    }
}
