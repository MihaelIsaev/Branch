import Vapor

extension Referral {
    public struct ReferrafLinkPayload: Content {
        fileprivate var branch_key: String?
        let channel, identity: String
        let feature = "referrals"
        let campaign = "referral-campaign"
    }
    
    public func link(on container: Container, payload: ReferrafLinkPayload) throws -> Future<String> {
        var payload = payload
        payload.branch_key = branch.key
        struct Response: Content {
            let url: String
        }
        return try branch.request(on: container, to: .url, method: .POST) { req in
            try req.content.encode(payload)
        }.flatMap { response in
            return try response.content.decode(Response.self).map { $0.url }
        }
    }
}
