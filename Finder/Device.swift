// Created by Geoff Pado on 4/7/18.
// Copyright © 2018 Cocoatype, LLC. All rights reserved.

import Foundation

struct Device: Codable {
    let identifier: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
    }
}
