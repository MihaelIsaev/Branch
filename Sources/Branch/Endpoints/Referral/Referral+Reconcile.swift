import Vapor

extension Referral {
    //    public struct UserReadModel: Content {
    //        let identity_id: Int
    //        let identity: String
    //        let link: String
    //    }
    //
    //    public func read(on container: Container, identity: String) throws -> Future<UserReadModel> {
    //        struct Response: Content {
    //            let url: String
    //        }
    //        return try branch.request(on: container, to: .profile, query: ["identity": identity, "branch_key": branch.key], method: .GET).flatMap { response in
    //            return try response.content.decode(UserReadModel.self)
    //        }
    //    }
    //    public func read(on container: Container, identity_id: Int) throws -> Future<UserReadModel> {
    //        struct Response: Content {
    //            let url: String
    //        }
    //        return try branch.request(on: container, to: .profile, query: ["identity_id": String(describing: identity_id), "branch_key": branch.key], method: .GET).flatMap { response in
    //            return try response.content.decode(UserReadModel.self)
    //        }
    //    }
}
