public class Executor {
    public init() {}
    
    public func execute(_ command: Command) async throws {
        switch command {
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
