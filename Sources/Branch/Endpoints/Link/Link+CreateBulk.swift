import Vapor

extension Link {
    public func createBulk<T: Codable>(on container: Container, payload: LinkCreatePayload<T>...) throws -> Future<[String]> {
        return try createBulk(on: container, payload: payload)
    }
    
    public func createBulk<T: Codable>(on container: Container, payload: [LinkCreatePayload<T>]) throws -> Future<[String]> {
        return try branch.request(on: container, to: .url, parameters: "bulk", branch.key, method: .POST) { req in
            try req.content.encode(payload)
        }.flatMap { response in
            return try response.content.decode([LinkCreateResponse].self).map { $0.map { $0.url } }
        }
    }
}
