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
                return buildURLString("/user")
            case let .repo(owner, repo):
                return buildURLString("/repos/\(owner)/\(repo)")
            }
        }
        
        private func buildURLString(_ urlString: String) -> String {
            if UserDefaultManagement.hostname != nil {
                return "/api/v3\(urlString)"
            }
            return urlString
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
