import Vapor

extension Referral {
    public struct ReferrafLinkPayload: Content {
        fileprivate var branch_key: String?
        let channel, identity: String
        let feature = "referrals"
        let campaign = "referral-campaign"
    }
    
    public func link(on eventLoop: EventLoop, payload: ReferrafLinkPayload) -> EventLoopFuture<String> {
        var payload = payload
        payload.branch_key = branch.configuration.key
        struct Response: Content {
            let url: String
        }
        return branch.request(on: eventLoop, to: .url, method: .POST) { req in
            try req.content.encode(payload)
        }.flatMapThrowing { response in
            try response.content.decode(Response.self)
        }.map { $0.url }
    }
}
