import Foundation
import APIController
import Models

struct RepositoryInteractor {
    let controller: GitHubControlling
    var repository: Repository?
    let configFile: ConfigurationFile
    
    init(
        controller: GitHubControlling = GitHubController(),
        configFile: ConfigurationFile
    ) {
        self.controller = controller
        self.configFile = configFile
    }
    
    func repo() async {
        do {
            guard
                let owner = configFile.owner,
                let repo = configFile.repo
            else {
                return
            }
            
            let repository = try await controller.repo(owner: owner, repo: repo)
            print("\(owner)/\(repository.name ?? "")")
            print("View this repository on GitHub: \(repository.cloneUrl ?? "")")
        } catch {
            print("Failed to get the repository: ", error)
        }
    }
}
