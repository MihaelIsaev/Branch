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
    
    public func update(on container: Container, link: String, payload: LinkUpdatePayload) throws -> Future<[String]> {
        var payload = payload
        payload.branch_key = branch.key
        payload.branch_secret = branch.secret
        struct Response: Content {
            let url: String
        }
        guard let link = link.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            throw Abort(.notAcceptable, reason: "Unable to escape link")
        }
        return try branch.request(on: container, to: .url, query: ["url": link, "branch_key": branch.key], method: .PUT) { req in
            try req.content.encode(payload)
        }.flatMap { response in
            return try response.content.decode([Response].self).map { $0.map { $0.url } }
        }
    }
}
