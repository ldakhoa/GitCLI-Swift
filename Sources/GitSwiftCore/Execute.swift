public func execute(_ command: Command) throws {
    switch command {
    case .repo:
        print("repo")
    case .pullRequest:
        print("pr")
    case .label:
        print("label")
    case .issue:
        print("issue")
    }
    
}
