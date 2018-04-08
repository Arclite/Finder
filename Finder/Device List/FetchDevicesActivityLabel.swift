//  Created by Geoff Pado on 4/8/18.
//  Copyright © 2018 Cocoatype, LLC. All rights reserved.

import UIKit

class FetchDevicesActivityLabel: UILabel {
    init() {
        super.init(frame: .zero)
        font = UIFont.preferredFont(forTextStyle: .footnote)
        translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        type(of: self).notImplementedInit()
    }
}
