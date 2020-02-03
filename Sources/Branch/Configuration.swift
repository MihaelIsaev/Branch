import Vapor

public struct BranchConfiguration {
    public let key, secret: String
    
    init (key: String, secret: String) {
        self.key = key
        self.secret = secret
    }
    
    /// It will try to initialize configuration with environment variables:
    /// - BRANCH_KEY
    /// - BRANCH_SECRET
    public static var environment: BranchConfiguration {
        guard
            let key = Environment.get("BRANCH_KEY"),
            let secret = Environment.get("BRANCH_SECRET")
            else {
            fatalError("Branch environmant variables not set")
        }
        return .init(key: key, secret: secret)
    }
}
