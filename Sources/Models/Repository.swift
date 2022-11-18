import Foundation

struct Repository {
    /// The HTTP URL of repository.
    var url: String?
    
    var owner: String?
    
    /// The date and time when the object was last updated.
    var updatedAt: Date?
    
    /// The name of the repository.
    var name: String?
}
