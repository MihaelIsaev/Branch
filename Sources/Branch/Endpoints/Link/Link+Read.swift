import Vapor

extension Link {
    public struct ReadLink<T: Codable>: Content {
        let campaign, channel, feature, stage, alias: String?
        let type: Int?
        let tags: [String]?
        let data: T
    }
    
    public func read<T: Codable>(on eventLoop: EventLoop, link: String, to: T.Type) -> EventLoopFuture<ReadLink<T>> {
        guard let link = link.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return eventLoop.makeFailedFuture(Abort(.notAcceptable, reason: "Unable to escape link"))
        }
        return branch.request(on: eventLoop, to: .url, query: ["url": link, "branch_key": branch.configuration.key], method: .GET).flatMapThrowing { response in
            try response.content.decode(ReadLink<T>.self)
        }
    }
}
