import Foundation
import Networkable
import Utilities

extension GitHubController {
    enum API: Request {
        case loginWithToken
        case repo(owner: String, repo: String)
        
        // MARK: - Request
        
        var headers: [String : String]? {
            return [
                "Accept": "application/vnd.github+json",
                "Authorization": "Bearer \(UserDefaultManagement.accessToken)"
            ]
        }
        
        var url: String {
            switch self {
            case .loginWithToken:
                return "/user"
            case let .repo(owner, repo):
                return "/repos/\(owner)/\(repo)"
            }
        }
        
        var method: Networkable.Method {
            switch self {
            case .loginWithToken, .repo:
                return .get
            }
        }
        
        func body() throws -> Data? {
            nil
        }
    }
}
