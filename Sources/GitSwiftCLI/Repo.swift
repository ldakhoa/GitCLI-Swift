import ArgumentParser
import GitSwiftCore

struct Repo: AsyncParsableCommand {
    public static let configuration = CommandConfiguration(
        abstract: "Work with GitHub repositories",
        discussion: """
        gitswift repo clone
        """,
        subcommands: [
            RepoView.self
        ]
    )
}

struct RepoView: AsyncParsableCommand {
    public static let configuration = CommandConfiguration(
        commandName: "view",
        abstract: "View a repository"
    )
}
