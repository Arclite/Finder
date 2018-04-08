//  Created by Geoff Pado on 4/8/18.
//  Copyright © 2018 Cocoatype, LLC. All rights reserved.

import Foundation

enum CredentialStorage {
    static func store(appleID: String, password: String) {
        URLCredentialStorage.shared.setDefaultCredential(URLCredential(user: appleID, password: password, persistence: .synchronizable), for: defaultProtectionSpace)
    }

    static var storedCredentials: (appleID: String, password: String)? {
        guard
          let existingCredential = URLCredentialStorage.shared.defaultCredential(for: defaultProtectionSpace),
          let appleID = existingCredential.user,
          let password = existingCredential.password
        else { return nil }

        return (appleID, password)
    }

    private static var defaultProtectionSpace: URLProtectionSpace {
        return URLProtectionSpace(host: "com.cocoatype.Finder", port: 443, protocol: nil, realm: nil, authenticationMethod: nil)
    }
}
