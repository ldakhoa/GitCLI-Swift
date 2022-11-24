import ArgumentParser

public class Executor {
    public init() {}
    
    public func execute(_ command: Command) async throws {
        switch command {
        case let .auth(hostname, tokenPath):
            let authInteractor = AuthInteractor(tokenPath: tokenPath, hostname: hostname)
            await authInteractor.loginWithToken()
        case let .repo(configFile):
            let repositoryInteractor = RepositoryInteractor(configFile: configFile)
            await repositoryInteractor.repo()
        case let .pullRequest(configFile, type):
            try await executePullRequest(configFile: configFile, type: type)
        }
    }
    
    private func executePullRequest(configFile: ConfigurationFile, type: Command.PullRequestType) async throws {
        let pullRequestInteractor = PullRequestInteractor(configFile: configFile)
        switch type {
        case .view:
            await pullRequestInteractor.getPullRequests()
        case .create:
            await pullRequestInteractor.createPullRequest()
        }
    }
}
