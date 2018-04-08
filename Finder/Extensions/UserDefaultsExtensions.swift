//  Created by Geoff Pado on 4/8/18.
//  Copyright © 2018 Cocoatype, LLC. All rights reserved.

import Foundation

extension UserDefaults {
    static var suite: UserDefaults {
        guard let suiteDefaults = UserDefaults(suiteName: "group.com.cocoatype.Finder") else { fatalError("Couldn't create defaults for suite") }
        return suiteDefaults
    }

    var baseURL: URL? {
        get { return url(forKey: DefaultsKeys.baseURL) }
        set(newURL) { set(newURL, forKey: DefaultsKeys.baseURL) }
    }
}

enum DefaultsKeys {
    static let baseURL = "DefaultsKeys.baseURL"
}