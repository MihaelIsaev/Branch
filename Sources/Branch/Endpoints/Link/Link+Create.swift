import Vapor

extension Link {
    public struct LinkCreatePayload<T: Codable>: Content {
        fileprivate var branch_key: String?
        var channel: String?
        var feature: String?
        var campaign: String?
        var stage: String?
        var tags: [String]?
        var data: T
        public init (channel: String? = nil, feature: String? = nil, campaign: String? = nil, stage: String? = nil, tags: [String], data: T) {
            self.channel = channel
            self.feature = feature
            self.campaign = campaign
            self.stage = stage
            self.tags = tags
            self.data = data
        }
        public init (channel: String? = nil, feature: String? = nil, campaign: String? = nil, stage: String? = nil, tags: String..., data: T) {
            self.init(channel: channel, feature: feature, campaign: campaign, stage: stage, tags: tags, data: data)
        }
    }
    
    struct LinkCreateResponse: Content {
        let url: String
    }
    
    public func create<T: Codable>(on container: Container, payload: LinkCreatePayload<T>) throws -> Future<String> {
        var payload = payload
        payload.branch_key = branch.key
        return try branch.request(on: container, to: .url, method: .POST) { req in
            try req.content.encode(payload)
        }.flatMap { response in
            return try response.content.decode(LinkCreateResponse.self).map { $0.url }
        }
    }
}
