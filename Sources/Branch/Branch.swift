import Vapor
import Foundation

public class Branch: Service {
    let baseURL = "https://api2.branch.io/v1/"
    
    let key, secret: String
    
    // MARK: Initialization
    
    public init(key: String, secret: String) {
        self.key = key
        self.secret = secret
    }
    
    typealias BeforeSend = (Request) throws -> Void
    
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
    
    func request(on container: Container,
                       to endpoint: Endpoint,
                       parameters: String...,
                       query: [String: String] = [:],
                       method: HTTPMethod = .GET,
                       beforeSend: @escaping BeforeSend = { _ in }) throws -> Future<Response> {
        let parameters = parameters.joined(separator: "/")
        let query: [String: String] = ["branch_key": key].merging(query) { $1 }
        let queryString: String = query.map { $0.key + "=" + $0.value }.joined(separator: "&")
        let url = baseURL + endpoint.rawValue + parameters + "?" + queryString
        let client = try container.make(Client.self)
        switch method {
        case .GET: return client.get(url, headers: [:], beforeSend: beforeSend)
        case .POST: return client.post(url, headers: [:], beforeSend: beforeSend)
        case .PUT: return client.put(url, headers: [:], beforeSend: beforeSend)
        case .PATCH: return client.patch(url, headers: [:], beforeSend: beforeSend)
        case .DELETE: return client.delete(url, headers: [:], beforeSend: beforeSend)
        default: throw Abort(.internalServerError, reason: "Unsupportable HTTP method")
        }
    }
    
    public lazy var app = App(self)
    public lazy var link = Link(self)
    public lazy var event = Event(self)
    public lazy var user = User(self)
    public lazy var referral = Referral(self)
    public lazy var webhook = Webhook(self)
}

extension Branch {
    public convenience init() {
        if let key = Environment.get("BRANCH_KEY"), let secret = Environment.get("BRANCH_SECRET") {
            self.init(key: key, secret: secret)
        } else {
            fatalError("Branch ENV variables not set")
        }
    }
}
