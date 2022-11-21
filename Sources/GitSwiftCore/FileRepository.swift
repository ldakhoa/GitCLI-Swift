import Foundation

public protocol FileRepository {
    func read(from path: String) throws -> String
    func readAsync(from path: String) async throws -> String
    func write(_ string: String, to path: String) throws
    func writeAsync(_ string: String, to path: String) async throws
}

public final class DefaultFileRepository {
    
    // MARK: Properties
    
    private let queue: DispatchQueue = .global()
    private let fileManager: FileManager = .default
    
    // MARK: Private functions
    
    private func makePath(from path: String) -> URL {
        URL(fileURLWithPath: path)
    }
    
    private func doRead(from path: String) throws -> String {
        let url = makePath(from: path)
        
        var isDir: ObjCBool = false
        guard fileManager.fileExists(atPath: url.path, isDirectory: &isDir) && !isDir.boolValue else {
            throw ReadWriteError.doesNotExist(path: url.path)
        }
        
        let string: String
        do {
            string = try String(contentsOf: url)
        } catch {
            throw ReadWriteError.readFailed(error)
        }
        
        return string
    }
    
    private func doWrite(_ string: String, to path: String) throws {
        guard let url = URL(string: path) else {
            throw ReadWriteError.doesNotExist(path: path)
        }
        
        let folderURL = url.deletingLastPathComponent()
        
        var isFolderDir: ObjCBool = false
        if fileManager.fileExists(atPath: folderURL.path, isDirectory: &isFolderDir) {
            if !isFolderDir.boolValue {
                throw ReadWriteError.canNotCreateFolder
            }
        } else {
            do {
                try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)
            } catch {
                throw ReadWriteError.canNotCreateFolder
            }
        }
        
        var isDir: ObjCBool = false
        guard !fileManager.fileExists(atPath: url.path, isDirectory: &isDir) || !isDir.boolValue else {
            throw ReadWriteError.canNotCreateFile
        }
        
        guard let data = string.data(using: .utf8) else {
            throw ReadWriteError.encodingFailed
        }
        
        do {
            try data.write(to: url)
        } catch {
            throw ReadWriteError.writeFailed(error)
        }
    }
    
}

extension DefaultFileRepository: FileRepository {
    public func read(from path: String) throws -> String {
        try queue.sync { try self.doRead(from: path) }
    }
    
    public func readAsync(from path: String) async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            queue.async {
                do {
                    let result = try self.doRead(from: path)
                    continuation.resume(with: .success(result))
                } catch {
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
    
    public func write(_ string: String, to path: String) throws {
        try queue.sync { try self.doWrite(string, to: path) }
    }
    
    public func writeAsync(
        _ string: String,
        to path: String
    ) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            queue.async {
                do {
                    try self.doWrite(string, to: path)
                    continuation.resume(with: .success(Void()))
                } catch {
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
}

enum ReadWriteError: LocalizedError, CustomStringConvertible {
    
    // MARK: Cases
    
    case doesNotExist(path: String)
    case readFailed(Error)
    case canNotCreateFolder
    case canNotCreateFile
    case encodingFailed
    case writeFailed(Error)
    
    var description: String {
        switch self {
        case let .doesNotExist(path):
            return "File does not exist at \(path)"
        case let .readFailed(error):
            return "Failed to read file \(error)"
        case .canNotCreateFolder:
            return "Cannot create folder"
        case .canNotCreateFile:
            return "Cannot create file"
        case .encodingFailed:
            return "Failed to encoding file"
        case let .writeFailed(error):
            return "Failed to write file \(error)"
        }
    }
}
