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
    
        public func reward(on container: Container, payload: ReferralRewardPayload) throws -> Future<Bool> {
            var payload = payload
            payload.branch_key = branch.key
            payload.branch_secret = branch.secret
            struct Response: Content {
                let success: Bool
            }
            return try branch.request(on: container, to: .credits, method: .POST) { req in
                try req.content.encode(payload)
            }.flatMap { response in
                return try response.content.decode(Response.self).map { $0.success }
            }
        }
}
