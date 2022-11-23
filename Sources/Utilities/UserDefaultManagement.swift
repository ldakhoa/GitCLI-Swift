import Foundation

private struct UserDefaultKeys {
    static let accessToken = "gitcliswift_access_token"
    static let hostname = "gitcliswift_hostname"
}

public final class UserDefaultManagement {
    private static var shared: UserDefaults? = UserDefaults(suiteName: "gitcli.swift.ldakhoa")
    private typealias Keys = UserDefaultKeys

    public static var accessToken: String {
        get {
            shared?.value(forKey: Keys.accessToken) as? String ?? ""
        }
        set {
            shared?.setValue(newValue, forKey: Keys.accessToken)
        }
    }
    
    public static var hostname: String? {
        get { shared?.value(forKey: Keys.hostname) as? String }
        set { shared?.setValue(newValue, forKey: Keys.hostname) }
    }
}
