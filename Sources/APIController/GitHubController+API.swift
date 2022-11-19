import Foundation
import Networkable

extension GitHubController {
    enum API: Request {
        case repo(owner: String, repo: String)
        
        // MARK: - Request
        
        var headers: [String : String]? {
            nil
        }
        
        var url: String {
            switch self {
            case let .repo(owner, repo):
                return "/repos/\(owner)/\(repo)"
            }
        }
        
        var method: Networkable.Method {
            switch self {
            case .repo:
                return .get
            }
        }
        
        func body() throws -> Data? {
            nil
        }
    }
}
