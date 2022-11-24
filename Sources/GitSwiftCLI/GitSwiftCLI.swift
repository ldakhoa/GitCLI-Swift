import ArgumentParser
import GitSwiftCore

struct Main: ParsableCommand {
    public static let configuration = CommandConfiguration(
        commandName: "gitswift",
        abstract: "A Swift CLI tool to make your Git flow easier",
        version: version,
        subcommands: [
            Auth.self,
            Repo.self,
            PullRequest.self,
        ]
    )
}
