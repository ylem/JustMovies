import Foundation
import Storage

class FakeDataStore: DataStore {

    var storage: [String: Data] = [:]

    var readError: Error?
    var writeError: Error?
    var deleteError: Error?

    var readDataForKeyCalled = false
    func read(dataForKey key: String) throws -> Data? {
        readDataForKeyCalled = true
        try handle(readError)
        return storage[key]
    }

    var writeDataForKeyCalled = false
    func write(data: Data, forKey key: String) throws {
        writeDataForKeyCalled = true
        try handle(writeError)
        storage[key] = data
    }

    var deleteDataForKeyCalled = false
    func delete(dataForKey key: String) throws {
        deleteDataForKeyCalled = true
        try handle(deleteError)
        storage.removeValue(forKey: key)
    }

    private func handle(_ error: Error?) throws {
        if let error = error {
            throw error
        }
    }

}
