import Foundation

extension Array where Element: Codable {
    static func stubbeds(from string: String) -> [Element] {
        let decoder = JSONDecoder()
        return string
            .data(using: .utf8)
            .flatMap { try? decoder.decode([Element].self, from: $0) } ?? []
    }
}
