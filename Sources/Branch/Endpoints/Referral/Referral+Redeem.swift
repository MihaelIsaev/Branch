import Vapor

extension Referral {
//        public struct ReferralRedeemPayload: Content {
//            fileprivate var branch_key, branch_secret: String?
//            let identity, amount, bucket: String
//            public init (identity: String, amount: String, bucket: String) {
//                self.identity = identity
//                self.amount = amount
//                self.bucket = bucket
//            }
//        }
//    
//        public func redeem(on container: Container, payload: ReferralRedeemPayload) throws -> Future<UserReadModel> {
//            struct Response: Content {
//                let url: String
//            }
//            return try branch.request(on: container, to: .redeem, method: .POST) { req in
//                try req.content.encode(payload)
//            }.flatMap { response in
//                    return try response.content.decode(Response.self).map { $0.success }
//            }
//        }
}
