import Vapor

extension User {
    public struct UserReadModel: Content {
        let identity_id: Int
        let identity: String
        let link: String
    }
    
    public func read(on eventLoop: EventLoop, identity: String) -> EventLoopFuture<UserReadModel> {
        branch.request(on: eventLoop, to: .profile, query: ["identity": identity, "branch_key": branch.configuration.key], method: .GET).flatMapThrowing { response in
            try response.content.decode(UserReadModel.self)
        }
    }
    public func read(on eventLoop: EventLoop, identity_id: Int) -> EventLoopFuture<UserReadModel> {
        branch.request(on: eventLoop, to: .profile, query: ["identity_id": String(describing: identity_id), "branch_key": branch.configuration.key], method: .GET).flatMapThrowing { response in
            try response.content.decode(UserReadModel.self)
        }
    }
}
