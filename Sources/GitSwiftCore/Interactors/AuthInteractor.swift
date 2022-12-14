import APIController
import ArgumentParser
import Foundation
import Pathos
import Utilities

struct AuthInteractor {
    private let tokenPath: String
    private let hostname: String?
    private let controller: GitHubControlling
    private let fileRepository: FileRepository
    
    init(
        tokenPath: String,
        hostname: String? = nil,
        controller: GitHubControlling = GitHubController(),
        fileRepository: FileRepository = DefaultFileRepository()
    ) {
        self.tokenPath = tokenPath
        self.hostname = hostname
        self.controller = controller
        self.fileRepository = fileRepository
//        self.setHostnameIfNeeded()
    }
    
    func loginWithToken() async {
        do {
            try await setTokenIfNeeded()
            let user = try await controller.loginWithToken()
            var uiMessage = "Login succeed with \(user.name ?? "Unknown")"
            
            if let hostname = hostname {
                uiMessage += " at \(hostname)"
            }
            
            UI.success(uiMessage)
        } catch {
            UI.error("Failed to sign in: \(error.localizedDescription)")
        }
    }
    
    private func setTokenIfNeeded() async throws {
        guard let path = makeTokenPath() else { return }
        let token = try await fileRepository.readAsync(from: path)
        
        if token != UserDefaultManagement.accessToken {
            UserDefaultManagement.accessToken = token.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    private func setHostnameIfNeeded() {
        let oldHostname = UserDefaultManagement.hostname
        if oldHostname == nil || oldHostname != self.hostname {
            UserDefaultManagement.hostname = hostname
        }
    }
    
    private func makeTokenPath() -> String? {
        guard tokenPath.contains("txt") else {
            UI.error("gitswift only accepts the access token from .txt file.")
            return nil
        }
        return tokenPath
    }
}
