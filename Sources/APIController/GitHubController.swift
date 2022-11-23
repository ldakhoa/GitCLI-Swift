import Foundation
import Networkable
import Models

public protocol GitHubControlling {
    /// Login with token.
    func loginWithToken() async throws -> User
    
    /// Get the repository information.
    func repo(owner: String, repo: String) async throws -> Repository
}

public final class GitHubController: GitHubControlling {
    private let session: NetworkableSession
    
    // MARK: - Init
    
    public init(
        session: NetworkableSession = NetworkSession.github
    ) {
        self.session = session
    }
    
    // MARK: - RemoteGitHubRepository
    
    public func loginWithToken() async throws -> User {
        try await parseData(from: .loginWithToken)
    }
    
    public func repo(owner: String, repo: String) async throws -> Repository {
        try await parseData(from: .repo(owner: owner, repo: repo))
    }
    
    // MARK: - Helpers
    
    private func parseData<T: Codable>(from request: GitHubController.API) async throws -> T {
        try await session.data(for: request, decoder: JSONDecoder())
    }
}
