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
        case .pullRequest:
            print("pr")
        case .label:
            print("label")
        case .issue:
            print("issue")
        }
        
    }
}
