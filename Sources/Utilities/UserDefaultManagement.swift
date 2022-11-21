
import Foundation

private struct UserDefaultKeys {
    static let accessToken = "gitcliswift_access_token"
}

public final class UserDefaultManagement {
    private static var shared: UserDefaults? = UserDefaults(suiteName: "gitcli.swift.ldakhoa")
    private typealias Keys = UserDefaultKeys

    public static var accessToken: String {
        get {
            if let result = shared?.object(forKey: Keys.accessToken) as? String {
                return result
            }
            return ""
        }
        set {
            shared?.set(newValue, forKey: Keys.accessToken)
        }
    }
}
