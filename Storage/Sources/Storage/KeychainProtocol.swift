import Foundation

public protocol KeychainProtocol {
    func copyMatchingSecureItem(query: CFDictionary, item: UnsafeMutablePointer<CFTypeRef?>?) -> OSStatus
    func addSecureItem(attributes: CFDictionary) -> OSStatus
    func updateSecureItem(query: CFDictionary, attributes: CFDictionary) -> OSStatus
    func deleteSecureItem(query: CFDictionary) -> OSStatus
}
