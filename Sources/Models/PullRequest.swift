import Foundation

public struct PullRequest: Codable {
    public var htmlUrl: String?
    public var number: UInt16?
    public var title: String?
    public var body: String?
    public var head: Base?
    public var base: Base?
    public var label: [Label]?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.htmlUrl = try container.decodeIfPresent(String.self, forKey: .htmlUrl)
        self.number = try container.decodeIfPresent(UInt16.self, forKey: .number)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.body = try container.decodeIfPresent(String.self, forKey: .body)
        self.head = try container.decodeIfPresent(Base.self, forKey: .head)
        self.base = try container.decodeIfPresent(Base.self, forKey: .base)
        self.label = try container.decodeIfPresent([Label].self, forKey: .label)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.htmlUrl, forKey: .htmlUrl)
        try container.encodeIfPresent(self.number, forKey: .number)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.body, forKey: .body)
        try container.encodeIfPresent(self.head, forKey: .head)
        try container.encodeIfPresent(self.base, forKey: .base)
        try container.encodeIfPresent(self.label, forKey: .label)
    }
    
    enum CodingKeys: String, CodingKey {
        case htmlUrl = "html_url"
        case number
        case title
        case body
        case head
        case base
        case label
    }
    
    public struct Request: Codable {
        public var owner: String
        public var repo: String
        public var pullNumber: UInt16?
        public var title: String?
        public var body: String?
        public var base: Base?
        
        public init(
            owner: String,
            repo: String,
            pullNumber: UInt16? = nil,
            title: String? = nil,
            body: String? = nil,
            base: Base? = nil
        ) {
            self.owner = owner
            self.repo = repo
            self.pullNumber = pullNumber
            self.title = title
            self.body = body
            self.base = base
        }
        
        public init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<PullRequest.Request.CodingKeys> = try decoder.container(keyedBy: PullRequest.Request.CodingKeys.self)
            self.owner = try container.decode(String.self, forKey: PullRequest.Request.CodingKeys.owner)
            self.repo = try container.decode(String.self, forKey: PullRequest.Request.CodingKeys.repo)
            self.pullNumber = try container.decodeIfPresent(UInt16.self, forKey: PullRequest.Request.CodingKeys.pullNumber)
            self.title = try container.decodeIfPresent(String.self, forKey: PullRequest.Request.CodingKeys.title)
            self.body = try container.decodeIfPresent(String.self, forKey: PullRequest.Request.CodingKeys.body)
            self.base = try container.decodeIfPresent(Base.self, forKey: PullRequest.Request.CodingKeys.base)
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: PullRequest.Request.CodingKeys.self)
            try container.encode(self.owner, forKey: PullRequest.Request.CodingKeys.owner)
            try container.encode(self.repo, forKey: PullRequest.Request.CodingKeys.repo)
            try container.encodeIfPresent(self.pullNumber, forKey: PullRequest.Request.CodingKeys.pullNumber)
            try container.encodeIfPresent(self.title, forKey: PullRequest.Request.CodingKeys.title)
            try container.encodeIfPresent(self.body, forKey: PullRequest.Request.CodingKeys.body)
            try container.encodeIfPresent(self.base, forKey: PullRequest.Request.CodingKeys.base)
        }
        
        enum CodingKeys: String, CodingKey {
            case owner
            case repo
            case pullNumber = "pull_number"
            case title
            case body
            case base
        }
        
        public func toData() throws -> Data? {
            return try? JSONEncoder().encode(self)
        }
    }
}
