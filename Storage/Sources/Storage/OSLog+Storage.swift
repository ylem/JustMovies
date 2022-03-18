import Foundation
import os.log

extension OSLog {
    static let storage = OSLog(subsystem: Bundle.init(for: KeychainDataStore.self).bundleIdentifier!,
                                  category: "storage")
}
