public enum Command {
    // TODO: (Auth): Support interactive setup
    case auth(hostname: String?, tokenPath: String)
    case repo(configFile: ConfigurationFile)
    case pullRequest(configFile: ConfigurationFile, type: PullRequestType)
    
    public enum PullRequestType {
        case view
        case create
    }
}
