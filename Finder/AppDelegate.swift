//  Created by Geoff Pado on 4/6/18.
//  Copyright © 2018 Cocoatype, LLC. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AppViewController()
        window?.makeKeyAndVisible()

        return true
    }
}
