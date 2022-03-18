import Foundation

public class SessionCache: DataStore {

    private let cache: NSCache<NSString, NSData>

    public init(cache: NSCache<NSString, NSData>) {
        self.cache = cache
    }

    public func read(dataForKey key: String) -> Data? {
        if let storedData = cache.object(forKey: NSString(string: key)) {
            return Data(referencing: storedData)
        } else {
            return nil
        }
    }

    public func write(data: Data, forKey key: String) {
        let storableData = NSData(data: data)
        cache.setObject(storableData, forKey: NSString(string: key))
    }

    public func delete(dataForKey key: String) {
        cache.removeObject(forKey: NSString(string: key))
    }

}
