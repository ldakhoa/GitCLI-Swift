import ArgumentParser
import GitSwiftCore

struct Main: ParsableCommand {
    public static let configuration = CommandConfiguration(
        commandName: "gitswift",
        abstract: "A Swift CLI tool to make your Git flow easier",
        version: version,
        subcommands: [
            Repo.self,
            PullRequest.self,
            Label.self,
            Issue.self,
        ]
    )
}

struct Repo: ParsableCommand {
    public static let configuration = CommandConfiguration(
        abstract: "Work with GitHub repositories",
        discussion: """
        gitswift repo clone
        """
    )
}

struct PullRequest: ParsableCommand {
    public static let configuration = CommandConfiguration(
        commandName: "pr",
        abstract: "Work with GitHub pull requests",
        discussion: """
        gitswift pr
        """
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
