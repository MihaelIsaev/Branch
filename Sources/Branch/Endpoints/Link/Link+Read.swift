import Vapor

extension Link {
    public struct ReadLink<T: Codable>: Content {
        let campaign, channel, feature, stage, alias: String?
        let type: Int?
        let tags: [String]?
        let data: T
    }
    
    public func read<T: Codable>(on container: Container, link: String) throws -> Future<ReadLink<T>> {
        guard let link = link.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            throw Abort(.notAcceptable, reason: "Unable to escape link")
        }
        return try branch.request(on: container, to: .url, query: ["url": link, "branch_key": branch.key], method: .GET).flatMap { response in
            return try response.content.decode(ReadLink<T>.self)
        }
    }
}
