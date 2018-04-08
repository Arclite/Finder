//  Created by Geoff Pado on 4/7/18.
//  Copyright © 2018 Cocoatype, LLC. All rights reserved.

import UIKit

class LoginButton: UIButton {
    init(_ title: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(tintColor, for: .normal)
        setTitle(title, for: .normal)
    }

    // MARK: Boilerplate

    override var intrinsicContentSize: CGSize { return CGSize(width: UIViewNoIntrinsicMetric, height: 44.0) }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        type(of: self).notImplementedInit()
    }
}
