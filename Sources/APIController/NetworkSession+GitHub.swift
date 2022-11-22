import Foundation
import Networkable
import Utilities

// TODO: - Use config file
extension NetworkSession {
    public static var github: NetworkSession {
        makeNetworkSession(fromURL: "https://api.github.com")
    }
    
    public static var githubEnterpriseServer: NetworkSession {
        guard let hostname = UserDefaultManagement.hostname else {
            return NetworkSession()
        }
        return makeNetworkSession(fromURL: "\(hostname)/api/v3")
    }
    
    public static var defaultNetworkSession: NetworkSession {
        UserDefaultManagement.hostname == nil ? github : githubEnterpriseServer
    }
    
    private static func makeNetworkSession(fromURL urlString: String) -> NetworkSession {
        let baseURL = URL(string: urlString)
        let requestBuilder = URLRequestBuilder(baseURL: baseURL)
        let logging = LoggingMiddleware(type: .info)
        let statusCodeValidation = StatusCodeValidationMiddleware()
        let middlewares: [Middleware] = [
            logging,
            ErrorDecoderMiddleware<GitHubError>(),
            statusCodeValidation,
        ]
        let result = NetworkSession(requestBuilder: requestBuilder, middlewares: middlewares)
        return result
    }
}
