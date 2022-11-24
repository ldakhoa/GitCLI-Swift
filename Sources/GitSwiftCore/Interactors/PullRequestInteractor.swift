import APIController
import Foundation

struct PullRequestInteractor {
    let controller: GitHubControlling
    
    init(
        controller: GitHubControlling = GitHubController()
    ) {
        self.controller = controller
    }
    
    func view() async throws {
        
    }
    
}
