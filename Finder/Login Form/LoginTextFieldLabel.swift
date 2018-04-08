//  Created by Geoff Pado on 4/7/18.
//  Copyright © 2018 Cocoatype, LLC. All rights reserved.

import UIKit

class LoginTextFieldLabel: UILabel {
    init(_ defaultText: String) {
        super.init(frame: .zero)
        font = UIFont.preferredFont(forTextStyle: .footnote)
        translatesAutoresizingMaskIntoConstraints = false
        text = defaultText
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        type(of: self).notImplementedInit()
    }
}
