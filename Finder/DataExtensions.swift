// Created by Geoff Pado on 4/7/18.
// Copyright (c) 2018 Cocoatype, LLC. All rights reserved.

import Foundation

extension Data {
    var hexEncodedString: String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}
