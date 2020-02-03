import Vapor
import Foundation

extension Application {
    public var branch: Branch { .init(self, client: client) }
}

extension Request {
    public var branch: Branch { .init(application, client: client) }
}

public enum BranchMode {
    case auto
    case manual(key: String, secret: String)
}

public struct Branch {
    let baseURL = "https://api2.branch.io/v1/"
    let application: Application
    let client: Client
    let mode: BranchMode
    
    public init (_ application: Application, client: Client, mode: BranchMode = .auto) {
        self.application = application
        self.client = client
        self.mode = mode
    }
    
    public var app: App { .init(self) }
    public var link: Link { .init(self) }
    public var event: Event { .init(self) }
    public var user: User { .init(self) }
    public var referral: Referral { .init(self) }
    public var webhook: Webhook { .init(self) }
}

// MARK: -
    
extension Branch {
    typealias BeforeSend = (inout ClientRequest) throws -> Void
    
    enum Endpoint: String {
        case url
        case app
        case event
        case profile
        case credits
        case redeem
        case credithistory
        case reconcile
        case eventresponse
    }
    
    func request(on eventLoop: EventLoop,
                       to endpoint: Endpoint,
                       parameters: String...,
                       query: [String: String] = [:],
                       method: HTTPMethod = .GET,
                       beforeSend: @escaping BeforeSend = { _ in }) -> EventLoopFuture<ClientResponse> {
        let parameters = parameters.joined(separator: "/")
        let query: [String: String] = ["branch_key": configuration.key].merging(query) { $1 }
        let queryString: String = query.map { $0.key + "=" + $0.value }.joined(separator: "&")
        let url = baseURL + endpoint.rawValue + parameters + "?" + queryString
        switch method {
        case .GET: return client.get(URI(string: url), headers: HTTPHeaders(), beforeSend: beforeSend)
        case .POST: return client.post(URI(string: url), headers: HTTPHeaders(), beforeSend: beforeSend)
        case .PUT: return client.put(URI(string: url), headers: HTTPHeaders(), beforeSend: beforeSend)
        case .PATCH: return client.patch(URI(string: url), headers: HTTPHeaders(), beforeSend: beforeSend)
        case .DELETE: return client.delete(URI(string: url), headers: HTTPHeaders(), beforeSend: beforeSend)
        default: return eventLoop.makeFailedFuture(Abort(.internalServerError, reason: "Unsupportable HTTP method"))
        }
    }
}

// MARK: - Configuration

extension Branch {
    struct ConfigurationKey: StorageKey {
        typealias Value = BranchConfiguration
    }

    public var configuration: BranchConfiguration {
        get {
            switch mode {
            case .auto:
                guard let config = application.storage[ConfigurationKey.self] else { fatalError("Branch not configured") }
                return config
            case .manual(let key, let secret):
                return BranchConfiguration(key: key, secret: secret)
            }
        }
        nonmutating set {
            application.storage[ConfigurationKey.self] = newValue
        }
    }
}
