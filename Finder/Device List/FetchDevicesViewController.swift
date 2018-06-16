//  Created by Geoff Pado on 4/8/18.
//  Copyright © 2018 Cocoatype, LLC. All rights reserved.

import Intents
import IntentsUI
import UIKit

class FetchDevicesViewController: UIViewController, INUIAddVoiceShortcutViewControllerDelegate {
    @available(iOS 12.0, *)
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        NSLog("finished with error: \(error.debugDescription)")
        guard presentedViewController == controller else { return }
        dismiss(animated: true, completion: nil)
    }

    @available(iOS 12.0, *)
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        NSLog("cancelled")
        guard presentedViewController == controller else { return }
        dismiss(animated: true, completion: nil)
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white

        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        let activityLabel = FetchDevicesActivityLabel()
        activityLabel.text = FetchDevicesViewController.fetchingText

        let stackView = UIStackView(arrangedSubviews: [activityIndicator, activityLabel])
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        self.activityIndicator = activityIndicator
        self.activityLabel = activityLabel

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let fetchOperation = FetchDevicesOperation()
        fetchOperation.completionBlock = { [weak self, weak fetchOperation] in
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.stopAnimating()
            }

            // handle failed fetching
            guard let devices = fetchOperation?.devices else {
                DispatchQueue.main.async { [weak self] in
                    self?.activityLabel.text = FetchDevicesViewController.fetchFailedText
                }

                return
            }

            // update activity status
            DispatchQueue.main.async {
                self?.activityLabel.text = FetchDevicesViewController.fetchSuccessfulText
            }

            // save device names to vocabulary
            let deviceNameSet = NSOrderedSet(array: devices.map { INSpeakableString(spokenPhrase: $0.name) })
            INVocabulary.shared().setVocabulary(deviceNameSet, of: .contactName)

            if #available(iOS 12.0, *) {
                let findDeviceIntent = FindDeviceIntent()
                findDeviceIntent.deviceName = UIDevice.current.name
                if let shortcut = INShortcut(intent: findDeviceIntent) {
                    DispatchQueue.main.async {
                        INVoiceShortcutCenter.shared.setShortcutSuggestions([shortcut])
                    }
                }
            }
        }

        operationQueue.addOperation(fetchOperation)
        activityIndicator.startAnimating()
    }

    // MARK: Boilerplate

    private weak var activityIndicator: UIActivityIndicatorView!
    private weak var activityLabel: UILabel!

    private let operationQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.qualityOfService = .userInitiated
        return operationQueue
    }()

    private static let fetchingText = NSLocalizedString("FetchDevicesViewController.fetchingText", comment: "Text displayed while fetching the list of devices")
    private static let fetchFailedText = NSLocalizedString("FetchDevicesViewController.fetchFailedText", comment: "Text displayed after failing to fetch the list of devices")
    private static let fetchSuccessfulText = NSLocalizedString("FetchDevicesViewController.fetchSuccessfulText", comment: "Text displayed after successfully fetching the list of devices")

    @available(*, unavailable)
    required init(coder: NSCoder) {
        type(of: self).notImplementedInit()
    }
}
