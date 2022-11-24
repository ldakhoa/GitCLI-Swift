import Foundation

public struct Base: Codable {
    public var label: String?
    public var ref: String?
    public var sha: String?
    public var user: User?
    public var repo: Repository?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.label = try container.decodeIfPresent(String.self, forKey: .label)
        self.ref = try container.decodeIfPresent(String.self, forKey: .ref)
        self.sha = try container.decodeIfPresent(String.self, forKey: .sha)
        self.user = try container.decodeIfPresent(User.self, forKey: .user)
        self.repo = try container.decodeIfPresent(Repository.self, forKey: .repo)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.label, forKey: .label)
        try container.encodeIfPresent(self.ref, forKey: .ref)
        try container.encodeIfPresent(self.sha, forKey: .sha)
        try container.encodeIfPresent(self.user, forKey: .user)
        try container.encodeIfPresent(self.repo, forKey: .repo)
    }
    
    enum CodingKeys: CodingKey {
        case label
        case ref
        case sha
        case user
        case repo
    }
}
