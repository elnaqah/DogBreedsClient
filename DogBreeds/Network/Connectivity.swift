import Network

protocol ConnectivityMonitor: Sendable {
    var isConnectedStream: AsyncStream<Bool> { get }
    var isConnected: Bool { get async }
}

struct ConnectivityMonitorImpl: ConnectivityMonitor {
    var isConnectedStream: AsyncStream<Bool> {
        let monitor = NWPathMonitor()
        monitor.start(queue: .global())
        return AsyncStream { continuation in
            monitor.pathUpdateHandler = { path in
                continuation.yield(path.status == .satisfied)
            }
        }
    }
    
    var isConnected: Bool {
        get async {
            await withCheckedContinuation { continuation in
                let monitor = NWPathMonitor()
                monitor.start(queue: .global())
                monitor.pathUpdateHandler = { path in
                    continuation.resume(returning: monitor.currentPath.status == .satisfied)
                    monitor.cancel()
                }
            }
        }
    }
}
