import Vapor

extension Link {
    public func createBulk<T: Codable>(on eventLoop: EventLoop, payload: LinkCreatePayload<T>...) -> EventLoopFuture<[String]> {
        createBulk(on: eventLoop, payload: payload)
    }
    
    public func createBulk<T: Codable>(on eventLoop: EventLoop, payload: [LinkCreatePayload<T>]) -> EventLoopFuture<[String]> {
        branch.request(on: eventLoop, to: .url, parameters: "bulk", branch.configuration.key, method: .POST) { req in
            try req.content.encode(payload)
        }.flatMapThrowing { response in
            try response.content.decode([LinkCreateResponse].self)
        }.map {
            $0.map { $0.url }
        }
    }
}
