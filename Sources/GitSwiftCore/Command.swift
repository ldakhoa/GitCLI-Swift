public enum Command {
    case repo(configFile: ConfigurationFile)
    case pullRequest
    case label
    case issue
}
