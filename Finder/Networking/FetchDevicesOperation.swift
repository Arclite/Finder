//  Created by Geoff Pado on 4/7/18.
//  Copyright © 2018 Cocoatype, LLC. All rights reserved.

import Foundation

class FetchDevicesOperation: Operation, URLSessionDataDelegate {
    // return value
    private(set) var devices: [Device]?

    override func start() {
        guard let loginOperation = dependencies.first as? LoginOperation, let baseURL = loginOperation.serviceURL else { isFinished = true; return }
        guard isCancelled == false else { isFinished = true; return }

        self.baseURL = baseURL

        localSessionTask = localURLSession.dataTask(with: request)
        localSessionTask?.resume()
    }

    // MARK: URL Request

    private var url: URL {
        guard let serviceURL = URL(string: "/fmipservice/client/web/initClient", relativeTo: baseURL) else { fatalError("Couldn't create fetch devices URL") }
        return serviceURL
    }

    private var request: URLRequest {
        var request = URLRequest(url: url)
        request.setValue("https://www.icloud.com", forHTTPHeaderField: "Origin")
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: [
            "clientContext": [
                "appName": "iCloud Find (Web)",
                "appVersion": "2.0",
                "timezone": "US/Eastern",
                "inactiveTime": 3571,
                "apiVersion": "3.0",
                "fmly": true
            ]
        ])

        return request
    }

    private var localURLSession: URLSession {
        return URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
    }

    // MARK: URLSessionDataDelegate

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        if isCancelled {
            isFinished = true
            localSessionTask?.cancel()
            return
        }

        completionHandler(.allow)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if isCancelled {
            isFinished = true
            localSessionTask?.cancel()
            return
        }

        localData.append(data)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if isCancelled {
            isFinished = true
            localSessionTask?.cancel()
            return
        }

        if Thread.isMainThread { NSLog("Main Thread!") }
        guard error == nil else {
            NSLog("received error fetching devices: \(error?.localizedDescription ?? "or not")")
            isFinished = true
            return
        }

        do {
            let response = try JSONDecoder().decode(Response.self, from: localData)
            devices = response.devices
        } catch {
            NSLog("received error fetching devices: \(error.localizedDescription)")
        }

        isFinished = true
    }

    // MARK: Boilerplate

    private var baseURL: URL?

    private var _finished = false
    override var isFinished: Bool {
        get { return _finished }
        set {
            willChangeValue(for: \.isFinished)
            _finished = newValue
            didChangeValue(for: \.isFinished)
        }
    }

    private var localData = Data()
    private var localSessionTask: URLSessionTask?

    private struct Response: Codable {
        let devices: [Device]

        enum CodingKeys: String, CodingKey {
            case devices = "content"
        }
    }
}
