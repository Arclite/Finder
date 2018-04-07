//  Created by Geoff Pado on 4/6/18.
//  Copyright © 2018 Cocoatype, LLC. All rights reserved.

import UIKit

class AppViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        UIViewController.notImplementedInit()
    }
}
