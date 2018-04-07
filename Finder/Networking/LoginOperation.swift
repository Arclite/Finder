// Created by Geoff Pado on 4/7/18.
// Copyright (c) 2018 Cocoatype, LLC. All rights reserved.

import Foundation

class LoginOperation: Operation, URLSessionDataDelegate {
    // return value
    private(set) var serviceURL: URL?

    override func start() {
        if isCancelled {
            isFinished = true
            return
        }

        localSessionTask = localURLSession.dataTask(with: request)
        localSessionTask?.resume()
    }

    // MARK: Login Values

    var appleID: String {
        guard let appleID = ProcessInfo.processInfo.environment["FINDER_APPLE_ID"] else { fatalError("Please provide your Apple ID with the environment variable 'FINDER_APPLE_ID'.") }
        return appleID
    }

    var password: String {
        guard let password = ProcessInfo.processInfo.environment["FINDER_PASSWORD"] else { fatalError("Please provide your Apple ID with the environment variable 'FINDER_PASSWORD'.") }
        return password
    }

    // MARK: URL Request

    private static var url: URL = {
        guard let loginURL = URL(string: "https://setup.icloud.com/setup/ws/1/login") else { fatalError("Couldn't create login URL") }
        return loginURL
    }()

    private var request: URLRequest {
        var request = URLRequest(url: LoginOperation.url)
        request.setValue("https://www.icloud.com", forHTTPHeaderField: "Origin")
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: [
            "apple_id": appleID,
            "password": password,
            "extended_login": true
        ])

        return request
    }

    private var localURLSession: URLSession {
        return URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
    }

    // MARK: URLSessionDataDelegate

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse,
                    completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
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
            NSLog("received error logging in: \(error?.localizedDescription ?? "or not")")
            isFinished = true
            return
        }

        do {
            let response = try JSONDecoder().decode(Response.self, from: localData)
            serviceURL = response.finderService?.url
        } catch {
            NSLog("received error logging in: \(error.localizedDescription)")
        }

        isFinished = true
    }

    // MARK: Boilerplate

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
        let webservices: [String: Service]
        var finderService: Service? {
            return webservices["findme"]
        }

        fileprivate struct Service: Codable {
            let urlString: String
            var url: URL? { return URL(string: urlString) }

            enum CodingKeys: String, CodingKey {
                case urlString = "url"
            }
        }
    }
}