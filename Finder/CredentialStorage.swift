//  Created by Geoff Pado on 4/8/18.
//  Copyright © 2018 Cocoatype, LLC. All rights reserved.

import Foundation
import Security

enum CredentialStorage {
    static func store(appleID: String, password: String) {
        guard let passwordData = password.data(using: .utf8) else { fatalError("Error generating password data") }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock,
            kSecAttrService as String: "com.cocoatype.Finder",
            kSecAttrAccount as String: appleID,
            kSecValueData as String: passwordData
        ]

        SecItemAdd(query as CFDictionary, nil)
    }

    static var storedCredentials: (appleID: String, password: String)? {
        var item: CFTypeRef?
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: "com.cocoatype.Finder",
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]

        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard
          status == errSecSuccess,
          let existingItem = item as? [String: Any],
          let passwordData = existingItem[kSecValueData as String] as? Data,
          let password = String(data: passwordData, encoding: .utf8),
          let appleID = existingItem[kSecAttrAccount as String] as? String
        else { return nil }

        return (appleID, password)
    }
}
