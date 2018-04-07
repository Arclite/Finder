//  Created by Geoff Pado on 4/7/18.
//  Copyright © 2018 Cocoatype, LLC. All rights reserved.

import UIKit

extension UIViewController {
    static func notImplementedInit() -> Never {
        fatalError("\(String(describing: type(of: self))) does not implement init(coder:)")
    }
}
