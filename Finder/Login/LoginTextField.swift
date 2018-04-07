// Created by Geoff Pado on 4/7/18.
// Copyright © 2018 Cocoatype, LLC. All rights reserved.

import UIKit

class LoginTextField: UITextField {
    init() {
        super.init(frame: .zero)
        borderStyle = .line
        translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        type(of: self).notImplementedInit()
    }
}
