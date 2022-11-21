import ArgumentParser

struct Auth: AsyncParsableCommand {
    public static let configuration = CommandConfiguration(
        abstract: "Authenticate gitswift with GitHub",
        subcommands: [
            AuthLogin.self
        ]
    )
}

struct AuthLogin: AsyncParsableCommand {
    public static let configuration = CommandConfiguration(
        commandName: "login",
        abstract: "Authenticate with a GitHub host. Currently only support authenticate with token from standard input."
    )
    
    @Option(
        name: [.customShort("h"), .long],
        help: "The hostname of the GitHub instance to authenticate with"
    )
    var hostname: String?
    
    @Option(
        name: [.customLong("with-token")],
        help: "Read token from standard input"
    )
    var tokenPath: String
}
