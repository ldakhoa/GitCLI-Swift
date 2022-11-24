import APIController
import Foundation
import Models

struct PullRequestInteractor {
    let controller: GitHubControlling
    let configFile: ConfigurationFile
    
    init(
        controller: GitHubControlling = GitHubController(),
        configFile: ConfigurationFile
    ) {
        self.controller = controller
        self.configFile = configFile
    }

    func getPullRequests() async {
        guard
            let owner = configFile.owner,
            let repo = configFile.repo
        else {
            return
        }
        
        do {
            let request = PullRequest.Request(owner: owner, repo: repo)
            let repositories = try await controller.pullRequests(from: request)
            print(repositories)
        } catch {
            UI.error(error.localizedDescription)
        }
        
    }
    
    func createPullRequest() async {
        
    }
}
