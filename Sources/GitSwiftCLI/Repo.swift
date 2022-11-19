import ArgumentParser

struct Repo: AsyncParsableCommand {
    public static let configuration = CommandConfiguration(
        abstract: "Work with GitHub repositories",
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
