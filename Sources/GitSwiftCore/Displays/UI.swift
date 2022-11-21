import Foundation
import ColorizeSwift

public class UI {
    enum LogType {
        case message
        case success
        case error
    }
    
    public static func success(_ message: String) {
        print(message, type: .success)
    }
    
    public static func message(_ message: String) {
        print(message, type: .message)
    }
    
    public static func error(_ message: String) {
        print(message, type: .error)
    }
    
    private static func print(_ message: String, type: LogType) {
        let colorMessage: String
        switch type {
        case .message:
            colorMessage = message
        case .success:
            colorMessage = message.green()
        case .error:
            colorMessage = message.red()
        }
        
        Swift.print(colorMessage)
    }
}
