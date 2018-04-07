//  Created by Geoff Pado on 4/6/18.
//  Copyright © 2018 Cocoatype, LLC. All rights reserved.

import os.log
import UIKit

class AppViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let finder = Finder()
        finder.login()

        finder.fetchDevices { devices, error in
            os_log("got devices:")
            devices?.forEach { os_log("%@: %@", $0.name, $0.identifier) }

            if let alertDeviceName = ProcessInfo.processInfo.environment["FINDER_ALERT_NAME"], let alertDevice = devices?.first(where: { $0.name == alertDeviceName }) {
                os_log("alerting %@: %@", alertDevice.name, alertDevice.identifier)
                finder.alert(alertDevice)
            }

            return
        }
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        UIViewController.notImplementedInit()
    }
}
