import Foundation

public struct User: Codable {
    public var htmlUrl: String?
    public var name: String?
    public var followers: Int?
    public var following: Int?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.htmlUrl = try container.decodeIfPresent(String.self, forKey: .htmlUrl)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.followers = try container.decodeIfPresent(Int.self, forKey: .followers)
        self.following = try container.decodeIfPresent(Int.self, forKey: .following)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.htmlUrl, forKey: .htmlUrl)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.followers, forKey: .followers)
        try container.encodeIfPresent(self.following, forKey: .following)
    }
    
    enum CodingKeys: String, CodingKey {
        case htmlUrl = "html_url"
        case name
        case followers
        case following
    }
}
