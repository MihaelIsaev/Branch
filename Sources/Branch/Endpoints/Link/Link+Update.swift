import Vapor

extension Link {
    public struct LinkUpdatePayload: Content {
        fileprivate var branch_key, branch_secret: String?
        let channel: String
        struct Data: Codable {
            let name, user_id: String
        }
        let data: Data
    }
    
    public func update(on eventLoop: EventLoop, link: String, payload: LinkUpdatePayload) -> EventLoopFuture<[String]> {
        var payload = payload
        payload.branch_key = branch.configuration.key
        payload.branch_secret = branch.configuration.secret
        struct Response: Content {
            let url: String
        }
        guard let link = link.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return eventLoop.makeFailedFuture(Abort(.notAcceptable, reason: "Unable to escape link"))
        }
        return branch.request(on: eventLoop, to: .url, query: ["url": link, "branch_key": branch.configuration.key], method: .PUT) { req in
            try req.content.encode(payload)
        }.flatMapThrowing { response in
            try response.content.decode([Response].self)
        }.map {
            $0.map { $0.url }
        }
    }
}
