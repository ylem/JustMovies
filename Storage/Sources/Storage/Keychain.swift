import Foundation

public class Keychain: KeychainProtocol {

    public init() { }

    public func copyMatchingSecureItem(query: CFDictionary, item: UnsafeMutablePointer<CFTypeRef?>?) -> OSStatus {
        return SecItemCopyMatching(query, item)
    }

    public func addSecureItem(attributes: CFDictionary) -> OSStatus {
        return SecItemAdd(attributes, nil)
    }

    public func updateSecureItem(query: CFDictionary, attributes: CFDictionary) -> OSStatus {
        return SecItemUpdate(query, attributes)
    }

    public func deleteSecureItem(query: CFDictionary) -> OSStatus {
        return SecItemDelete(query)
    }

}
