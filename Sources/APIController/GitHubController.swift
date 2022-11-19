import Foundation
import Networkable
import Models

public protocol GitHubControlling {
    /// Get the repository information.
    func repo(owner: String, repo: String) async throws -> Repository
}

public final class GitHubController: GitHubControlling {
    private let session: NetworkableSession
    
    // MARK: - Init
    
    public init(session: NetworkableSession = NetworkSession.github) {
        self.session = session
    }
    
    // MARK: - RemoteGitHubRepository
    
    public func repo(owner: String, repo: String) async throws -> Repository {
        let request = API.repo(owner: owner, repo: repo)
        let repo = try await session.data(for: request, decoder: JSONDecoder()) as Repository
        return repo
    }
}
