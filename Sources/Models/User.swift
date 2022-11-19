import Foundation

public struct User: Codable {
    public var htmlUrl: String?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.htmlUrl = try container.decodeIfPresent(String.self, forKey: .htmlUrl)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.htmlUrl, forKey: .htmlUrl)
    }
    
    enum CodingKeys: String, CodingKey {
        case htmlUrl = "html_url"
    }
}
