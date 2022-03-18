import Foundation

public class DiskStorage: DataStore {

    private let fileManager = FileManager.default
    private let applicationSupportDirectoryURL: URL

    public init() {
        let appSupportURLs = fileManager.urls(for: .applicationSupportDirectory,
                                              in: .userDomainMask)
        guard let url = appSupportURLs.first else {
            fatalError("No application support directory url found")
        }
        applicationSupportDirectoryURL = url
    }

    public func read(dataForKey key: String) throws -> Data? {
        let url = applicationSupportDirectoryURL.appendingPathComponent(key)
        return try Data(contentsOf: url)
    }

    public func write(data: Data, forKey key: String) throws {
        let url = applicationSupportDirectoryURL.appendingPathComponent(key)
        try data.write(to: url)
    }

    public func delete(dataForKey key: String) throws {
        let url = applicationSupportDirectoryURL.appendingPathComponent(key)
        try fileManager.removeItem(at: url)
    }

}
