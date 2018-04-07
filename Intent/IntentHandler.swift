//  Created by Geoff Pado on 4/7/18.
//  Copyright © 2018 Cocoatype, LLC. All rights reserved.

import os.log
import Intents

class IntentHandler: INExtension, INSendMessageIntentHandling {
    func resolveRecipients(for intent: INSendMessageIntent, with completion: @escaping ([INPersonResolutionResult]) -> Void) {
        if let recipients = intent.recipients {
            // If no recipients were provided we'll need to prompt for a value.
            if recipients.count == 0 {
                completion([INPersonResolutionResult.needsValue()])
                return
            }

            let resolutionResults = recipients.map { INPersonResolutionResult.success(with: $0) }
            completion(resolutionResults)
        }
    }

    func resolveContent(for intent: INSendMessageIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        completion(INStringResolutionResult.success(with: "Find My iPhone Alert"))
    }

    func confirm(intent: INSendMessageIntent, completion: @escaping (INSendMessageIntentResponse) -> Void) {
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INSendMessageIntent.self))
        let response = INSendMessageIntentResponse(code: .ready, userActivity: userActivity)
        completion(response)
    }

    func handle(intent: INSendMessageIntent, completion: @escaping (INSendMessageIntentResponse) -> Void) {
        let finder = Finder()
        finder.login()

        finder.fetchDevices { devices, error in
            os_log("got devices:")
            devices?.forEach { os_log("%@: %@", $0.name, $0.identifier) }

            if let alertDeviceName = ProcessInfo.processInfo.environment["FINDER_ALERT_NAME"], let alertDevice = devices?.first(where: { $0.name == alertDeviceName }) {
                os_log("alerting %@: %@", alertDevice.name, alertDevice.identifier)
                finder.alert(alertDevice) {
                    let userActivity = NSUserActivity(activityType: NSStringFromClass(INSendMessageIntent.self))
                    let response = INSendMessageIntentResponse(code: .success, userActivity: userActivity)
                    completion(response)
                }
            }

            return
        }
    }
}

