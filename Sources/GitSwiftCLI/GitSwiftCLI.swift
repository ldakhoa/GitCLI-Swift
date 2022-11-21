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
            Label.self,
            Issue.self,
        ]
    )
}

struct Label: ParsableCommand {
    public static let configuration = CommandConfiguration(
        abstract: "Work with GitHub labels",
        discussion: """
        gitswift label
        """
    )
}

struct Issue: ParsableCommand {
    public static let configuration = CommandConfiguration(
        abstract: "Work with GitHub issues",
        discussion: """
        gitswift issue
        """
    )
}
