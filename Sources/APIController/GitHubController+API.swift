import Foundation
import Networkable
import Models
import Utilities

extension GitHubController {
    typealias PRRequest = PullRequest.Request
    
    enum API: Request {
        case loginWithToken
        case repo(owner: String, repo: String)
        case createPR(request: PRRequest)
        case prs(request: PRRequest)
        
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
                return buildURLString(fromPath: "/user")
            case let .repo(owner, repo):
                return buildURLString(fromPath: "/repos/\(owner)/\(repo)")
            case let .createPR(request):
                return buildURLString(fromPath: "/repos/\(request.owner)")
            case let .prs(request):
                return buildURLString(fromPath: "/repos/\(request.owner)/\(request.repo)/pulls")
            }
        }
        
        private func buildURLString(fromPath path: String) -> String {
            if let hostname = UserDefaultManagement.hostname,
               let hostnameURL = URL(string: hostname),
               let url = URL(string: "/api/v3\(path)", relativeTo: hostnameURL) {
                return url.absoluteString
            }
            return path
        }
        
        var method: Networkable.Method {
            switch self {
            case .loginWithToken, .repo, .prs:
                return .get
            case .createPR:
                return .post
            }
        }
        
        func body() throws -> Data? {
            switch self {
            case let .createPR(request):
                return try? request.toData()
            default:
                return nil
            }
        }
    }
}
