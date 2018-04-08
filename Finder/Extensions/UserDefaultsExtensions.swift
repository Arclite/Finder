//  Created by Geoff Pado on 4/8/18.
//  Copyright © 2018 Cocoatype, LLC. All rights reserved.

import Foundation

extension UserDefaults {
    static var suite: UserDefaults {
        // TODO: Replace with correct UserDefaults for suite
        return standard
    }
}

enum DefaultsKeys {
    static let serviceURL = "DefaultsKeys.serviceURL"
}