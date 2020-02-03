import Vapor

extension Referral {
        public struct ReferralRewardPayload: Content {
            fileprivate var branch_key, branch_secret: String?
            let identity, amount, bucket: String
            public init (identity: String, amount: String, bucket: String) {
                self.identity = identity
                self.amount = amount
                self.bucket = bucket
            }
        }
    
        public func reward(on eventLoop: EventLoop, payload: ReferralRewardPayload) -> EventLoopFuture<Bool> {
            var payload = payload
            payload.branch_key = branch.configuration.key
            payload.branch_secret = branch.configuration.secret
            struct Response: Content {
                let success: Bool
            }
            return branch.request(on: eventLoop, to: .credits, method: .POST) { req in
                try req.content.encode(payload)
            }.flatMapThrowing { response in
                try response.content.decode(Response.self)
            }.map { $0.success }
        }
}
