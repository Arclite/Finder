// Created by Geoff Pado on 4/7/18.
// Copyright (c) 2018 Cocoatype, LLC. All rights reserved.

import os.log
import Foundation

class Finder {
    func fetchDevices(_ callback: @escaping ([Device]?, Error?) -> Void) {
        let loginOperation = LoginOperation()
        let postLoginOperation = PostLoginOperation()
        postLoginOperation.addDependency(loginOperation)

        postLoginOperation.completionBlock = { [weak postLoginOperation] in
            callback(postLoginOperation?.devices, nil)
        }

        operationQueue.addOperations([loginOperation, postLoginOperation], waitUntilFinished: false)
    }

    // MARK: Boilerplate

    let operationQueue = OperationQueue()
}
