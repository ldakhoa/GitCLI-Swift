import ArgumentParser
import GitSwiftCore

extension Command {
    init?(command: ParsableCommand) throws {
        switch command {
        case let command as Repo:
            self = .repo
        case let command as PullRequest:
            self = .pullRequest
        case let command as Label:
            self = .label
        case let command as Issue:
            self = .issue
        default:
            return nil
        }
    }
}

public func run(arguments: [String]) {
    do {
        var parsedCommand = try Main.parseAsRoot(arguments)
        if let command = try Command(command: parsedCommand) {
            try execute(command)
        } else {
            try parsedCommand.run()
        }
    } catch let error {
        Main.exit(withError: error)
    }
    
}
