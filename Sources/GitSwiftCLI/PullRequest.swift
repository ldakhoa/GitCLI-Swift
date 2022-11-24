import ArgumentParser
import Foundation

struct PullRequest: AsyncParsableCommand {
    public static let configuration = CommandConfiguration(
        commandName: "pr",
        abstract: "Work with GitHub pull requests",
        subcommands: [
            PullRequestView.self
        ]
    )
}

struct PullRequestView: AsyncParsableCommand {
    public static let configuration = CommandConfiguration(
        commandName: "view",
        abstract: "Display the title, body, and other information about a pull request."
    )
}
