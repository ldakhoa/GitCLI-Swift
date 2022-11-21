public enum Command {
    // TODO: (Auth): Support interactive setup
    case auth(hostname: String?, tokenPath: String)
    case repo(configFile: ConfigurationFile)
    case pullRequest
    case label
    case issue
}
