import ArgumentParser
import GitSwiftCore

extension Command {
    init?(command: ParsableCommand) throws {
        switch command {
        case let command as Repo:
            self = .repo
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
