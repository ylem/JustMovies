import Foundation

public enum KeychainDataStoreError: LocalizedError {
    case unhandledError(status: OSStatus)
    case unexpectedItemFormat
    case itemNotFound

    public var errorDescription: String? {
        switch self {
        case .unhandledError(status: let status):
            return "Unhandled error. Status: \(status)"
        case .unexpectedItemFormat:
            return "Unexpected item format"
        case .itemNotFound:
            return "Item not found"
        }
    }
}

public class KeychainDataStore {

    private let keychain: KeychainProtocol
    private let service = "com.jlr.Storage"
    private let keychainAccessGroup: String?

    public init(keychain: KeychainProtocol, keychainAccessGroup: String?) {
        self.keychain = keychain
        self.keychainAccessGroup = keychainAccessGroup
    }

    private func getData(forAccount account: String) throws -> Data? {
        var query = createQuery(forAccount: account)
        query[kSecReturnData as String] = true

        var item: CFTypeRef?
        let status = keychain.copyMatchingSecureItem(query: query as CFDictionary, item: &item)
        guard status != errSecItemNotFound else {
            return nil
        }
        guard status == errSecSuccess else {
            let error = KeychainDataStoreError.unhandledError(status: status)
            throw error
        }
        guard let data = item as? Data else {
            throw KeychainDataStoreError.unexpectedItemFormat
        }

        return data
    }

    private func addData(forAccount account: String, data: Data) throws {
        var query = createQuery(forAccount: account)
        query[kSecValueData as String] = data

        let status = keychain.addSecureItem(attributes: query as CFDictionary)
        guard status == errSecSuccess else {
            throw KeychainDataStoreError.unhandledError(status: status)
        }
    }

    private func updateData(forAccount account: String, data: Data) throws {
        let query = createQuery(forAccount: account)
        let attributes: [String: Any] = [kSecValueData as String: data]
        let status = keychain.updateSecureItem(query: query as CFDictionary, attributes: attributes as CFDictionary)
        guard status != errSecItemNotFound else {
            throw KeychainDataStoreError.itemNotFound
        }
        guard status == errSecSuccess else {
            throw KeychainDataStoreError.unhandledError(status: status)
        }
    }

    private func deleteData(forAccount account: String) throws {
        let query = createQuery(forAccount: account)
        let status = keychain.deleteSecureItem(query: query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainDataStoreError.unhandledError(status: status)
        }
    }

    private func createQuery(forAccount account: String) -> [String: Any] {
        var query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: account,
                                    kSecAttrService as String: service]

        if let group = keychainAccessGroup {
            query[kSecAttrAccessGroup as String] = group
        }
        return query
    }

}

extension KeychainDataStore: DataStore {

    public func read(dataForKey key: String) throws -> Data? {
        return try getData(forAccount: key)
    }

    public func write(data: Data, forKey key: String) throws {
        if try getData(forAccount: key) != nil {
            try updateData(forAccount: key, data: data)
        } else {
            try addData(forAccount: key, data: data)
        }
    }

    public func delete(dataForKey key: String) throws {
        try deleteData(forAccount: key)
    }

}
