//  Created by Geoff Pado on 4/7/18.
//  Copyright © 2018 Cocoatype, LLC. All rights reserved.

import os.log
import Intents
import UIKit

class IntentHandler: INExtension, INSendMessageIntentHandling, FindDeviceIntentHandling {
    func resolveRecipients(for intent: INSendMessageIntent, with completion: @escaping ([INPersonResolutionResult]) -> Void) {
        guard let recipients = intent.recipients else { return }

        switch recipients.count {
        case 0:
            let currentDevice = INPerson(personHandle: INPersonHandle(value: UIDevice.current.name, type: .unknown), nameComponents: nil, displayName: UIDevice.current.name, image: nil, contactIdentifier: nil, customIdentifier: nil)
            completion([INPersonResolutionResult.success(with: currentDevice)])
        case 1:
            completion(recipients.map { INPersonResolutionResult.success(with: $0) })
        default:
            completion([INPersonResolutionResult.disambiguation(with: recipients)])
        }
    }

    func resolveContent(for intent: INSendMessageIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        completion(INStringResolutionResult.success(with: "Find My iPhone"))
    }

    func confirm(intent: INSendMessageIntent, completion: @escaping (INSendMessageIntentResponse) -> Void) {
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INSendMessageIntent.self))
        let response = INSendMessageIntentResponse(code: .ready, userActivity: userActivity)
        completion(response)
    }

    func handle(intent: INSendMessageIntent, completion: @escaping (INSendMessageIntentResponse) -> Void) {
        guard let alertDeviceName = intent.recipients?.first?.displayName else { return }
        let finder = Finder()
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INSendMessageIntent.self))

        finder.login()

        finder.fetchDevices { devices, error in
            os_log("got devices:")
            devices?.forEach { os_log("%@: %@", $0.name, $0.identifier) }

            if let alertDevice = devices?.first(where: { $0.name == alertDeviceName }) {
                os_log("alerting %@: %@", alertDevice.name, alertDevice.identifier)
                finder.alert(alertDevice) {
                    let response = INSendMessageIntentResponse(code: .success, userActivity: userActivity)
                    completion(response)
                }
            } else {
                completion(INSendMessageIntentResponse(code: .failure, userActivity: userActivity))
            }

            return
        }
    }

    @available(iOSApplicationExtension 12.0, *)
    func confirm(intent: FindDeviceIntent, completion: @escaping (FindDeviceIntentResponse) -> Void) {
        let response = FindDeviceIntentResponse(code: .ready, userActivity: nil)
        completion(response)
    }

    @available(iOSApplicationExtension 12.0, *)
    func handle(intent: FindDeviceIntent, completion: @escaping (FindDeviceIntentResponse) -> Void) {
        guard let alertDeviceName = intent.deviceName else { return }
        let finder = Finder()

        finder.login()

        finder.fetchDevices { devices, error in
            os_log("got devices:")
            devices?.forEach { os_log("%@: %@", $0.name, $0.identifier) }

            if let alertDevice = devices?.first(where: { $0.name == alertDeviceName }) {
                os_log("alerting %@: %@", alertDevice.name, alertDevice.identifier)
                finder.alert(alertDevice) {
                    let response = FindDeviceIntentResponse(code: .success, userActivity: nil)
                    completion(response)
                }
            } else {
                completion(FindDeviceIntentResponse(code: .failure, userActivity: nil))
            }

            return
        }
    }
}

