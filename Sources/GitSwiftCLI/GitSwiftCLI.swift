import ArgumentParser
import GitSwiftCore

//@main
//public struct GitSwiftCLI: ParsableCommand {
//    public static let configuration = CommandConfiguration(
//        commandName: "gitswift",
//        abstract: "A Swift CLI tool to make your Git flow easier",
//        version: "0.0.1"
//    )
//
//    public init() {}
//}

struct Repo: ParsableCommand {
    public static let configuration = CommandConfiguration(
        abstract: "Work with GitHub repositories",
        discussion: """
        gitswift repo clone
        """
    )
    
}

struct Main: ParsableCommand {
    public static let configuration = CommandConfiguration(
        commandName: "gitswift",
        abstract: "A Swift CLI tool to make your Git flow easier",
        version: version,
        subcommands: [
            Repo.self,
        ]
    )
}
