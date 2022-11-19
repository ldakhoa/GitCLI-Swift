import Foundation

public struct Repository: Codable {
    /// The HTTP URL of the repository.
    public var cloneUrl: String?
    
    /// The description of the repository.
    public var description: String?
    
    /// The owner of the repository.
    public var owner: User?
    
    /// The name of the repository.
    public var name: String?
    
    /// Topics of the repository.
    public var topics: [String]?
    
    public var stargazersCount: Int?
    
    public init(
        cloneUrl: String? = nil,
        description: String? = nil,
        owner: User? = nil,
        name: String? = nil,
        topics: [String]? = nil,
        stargazersCount: Int? = nil
    ) {
        self.cloneUrl = cloneUrl
        self.owner = owner
        self.description = description
        self.name = name
        self.topics = topics
        self.stargazersCount = stargazersCount
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cloneUrl = try container.decodeIfPresent(String.self, forKey: .cloneUrl)
        self.owner = try container.decodeIfPresent(User.self, forKey: .owner)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.topics = try container.decodeIfPresent([String].self, forKey: .topics)
        self.stargazersCount = try container.decodeIfPresent(Int.self, forKey: .stargazersCount)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.cloneUrl, forKey: .cloneUrl)
        try container.encodeIfPresent(self.owner, forKey: .owner)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.topics, forKey: .topics)
        try container.encodeIfPresent(self.stargazersCount, forKey: .stargazersCount)
    }
    
    enum CodingKeys: String, CodingKey {
        case cloneUrl = "clone_url"
        case owner
        case description
        case name
        case topics
        case stargazersCount = "stargazers_count"
    }
}

#if DEBUG

extension Repository {
    static var stubbed: Repository {
        Repository(
            cloneUrl: "https://github.com/ldakhoa/seedee.git",
            name: "seedee"
        )
    }
}

#endif
