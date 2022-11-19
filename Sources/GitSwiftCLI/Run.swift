import ArgumentParser
import Foundation
import GitSwiftCore
import GitConfig
import Pathos

extension Command {
    init?(command: ParsableCommand) throws {
        switch command {
        case _ as RepoView:
            let configFile = try configFromFile()
            self = .repo(configFile: configFile)
        case _ as PullRequest:
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

private func configFromFile() throws -> ConfigurationFile {
    let currentDirectory = FileManager.default.currentDirectoryPath
    var configurationFile = ConfigurationFile()
    
    try Path(currentDirectory).asWorkingDirectory {
        let pattern = Path(".git") + "config"
        for configFile in try pattern.glob() {
            let source = try configFile.readUTF8String()
            let configuration = try Configuration(source)
            guard
                let remote = configuration["remote \"origin\""],
                let remoteUrl = remote["url"]
            else {
                continue
            }
            let remoteUrlString = remoteUrl.description
            configurationFile.originUrl = remoteUrlString
            
            if let firstRange = remoteUrlString.range(of: ":"), let lastRange = remoteUrlString.range(of: ".git") {
                let strFilterred = String(remoteUrlString[firstRange.upperBound ..< lastRange.lowerBound])
                    .split(separator: "/")
                configurationFile.owner = String(strFilterred[0])
                configurationFile.repo = String(strFilterred[1])
            }
        }
    }
    
    return configurationFile
}

public func run(arguments: [String]) async {
    do {
        var parsedCommand = try Main.parseAsRoot(arguments)
        if let command = try Command(command: parsedCommand) {
            let executor = Executor()
            try await executor.execute(command)
        } else {
            try parsedCommand.run()
        }
    } catch let error {
        Main.exit(withError: error)
    }
    
}
