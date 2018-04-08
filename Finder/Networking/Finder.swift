//  Created by Geoff Pado on 4/7/18.
//  Copyright © 2018 Cocoatype, LLC. All rights reserved.

import os.log
import Foundation

class Finder {
    func login() {
        operationQueue.addOperation(loginOperation)
    }

    func fetchDevices(_ callback: @escaping ([Device]?, Error?) -> Void) {
        let fetchDevicesOperation = FetchDevicesOperation()
        fetchDevicesOperation.addDependency(loginOperation)

        fetchDevicesOperation.completionBlock = { [weak fetchDevicesOperation] in
            callback(fetchDevicesOperation?.devices, nil)
        }

        operationQueue.addOperation(fetchDevicesOperation)
    }

    func alert(_ device: Device, _ callback: (() -> Void)? = nil) {
        let alertOperation = AlertOperation(device)
        alertOperation.addDependency(loginOperation)
        alertOperation.completionBlock = callback

        operationQueue.addOperation(alertOperation)
    }

    // MARK: Boilerplate

    private let loginOperation = LoginOperation()
    private let operationQueue = OperationQueue()
}
