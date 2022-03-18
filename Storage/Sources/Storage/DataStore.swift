import Foundation

public protocol DataStore {
    func read(dataForKey key: String) throws -> Data?
    func write(data: Data, forKey key: String) throws
    func delete(dataForKey key: String) throws

    func fetchAll<T: Decodable>(with storageKey: String, decoder: JSONDecoder) -> T?
    func save(data: Data, with storageKey: String)
}

public extension DataStore {

    /// Fetch all objects from a particular data store
    /// - Parameters:
    ///   - storageKey: string key in store
    ///   - decoder: Object decoder
    /// - Returns: return requested decoded object or nil if cannot find it.
    func fetchAll<T: Decodable>(with storageKey: String,
                                decoder: JSONDecoder) -> T? {
        do {
            guard let storedData = try read(dataForKey: storageKey) else { return nil }
            return try decoder.decode(T.self, from: storedData)
        } catch {
            return nil
        }
    }

    /// Save data into a particular data store
    /// - Parameters:
    ///   - object: saved the object must be encodable
    ///   - storageKey: key in store
    ///   - encoder: encoder
    func save<Object: Encodable>(object: Object,
                                 with storageKey: String,
                                 encoder: JSONEncoder) {
        guard let data = try? encoder.encode(object) else { return }
        save(data: data, with: storageKey)
    }

    /// Save data into a particular data store
    /// - Parameters:
    ///   - data: data can be encoded from a object.
    ///   - storageKey: key in store
    func save(data: Data, with storageKey: String) {
        do {
            try write(data: data, forKey: storageKey)
        } catch {
            #if DEBUG
            print("Failed to store object. Error: \(error.localizedDescription)")
            #endif
        }
    }

}
