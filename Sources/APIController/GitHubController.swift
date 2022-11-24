import Foundation
import Networkable
import Models

public protocol GitHubControlling {
    /// Login with token.
    func loginWithToken() async throws -> User
    
    /// Get the repository information.
    func repo(owner: String, repo: String) async throws -> Repository
    
    /// Create a pull request.
    func createPullRequest(from request: PullRequest.Request) async throws -> PullRequest
    
    /// Get all pull requests from repo
    func pullRequests(from request: PullRequest.Request) async throws -> [PullRequest]
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
    
    public func createPullRequest(from request: PullRequest.Request) async throws -> PullRequest {
        try await parseData(from: .createPR(request: request))
    }
    
    public func pullRequests(from request: PullRequest.Request) async throws -> [PullRequest] {
        try await parseData(from: .prs(request: request))
    }
    
    // MARK: - Helpers
    
    private func parseData<T: Codable>(from request: GitHubController.API) async throws -> T {
        try await session.data(for: request, decoder: JSONDecoder())
    }
}
