import Foundation

struct GitHubError: LocalizedError, Codable, Equatable {
    /// A message that describes why the error did occur.
    let message: String
    
    public var errorDescription: String? { message }
}
