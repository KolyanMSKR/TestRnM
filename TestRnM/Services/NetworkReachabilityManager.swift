//
//  NetworkReachabilityManager.swift
//  TestRnM
//
//  Created by Anderen on 03.04.2025.
//

import Network

protocol NetworkReachabilityProtocol {
    var isNetworkAvailable: Bool { get }
}

class NetworkReachabilityManager: NetworkReachabilityProtocol {

    var isNetworkAvailable: Bool {
        isReachable
    }

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    private var isReachable: Bool = false

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isReachable = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }

    deinit {
        monitor.cancel()
    }
    
}
