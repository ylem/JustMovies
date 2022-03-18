import class Foundation.Bundle

private class CurrentBundleFinder {}

public extension Foundation.Bundle {

    /// Load Bundle from list of resource URL, fixed the problem
    /// about SwiftUI Previews crashed due to package bundle loading issue
    /// - Parameter packageName: The name of your local package, prepended by "LocalPackages_"
    /// for iOS and "PackageName_" for macOS. You may have same PackageName and TargetName
    /// e.g. BundleModule_BundleModule
    /// - Returns: found bundle
    static func packageBundle(name packageName: String) -> Bundle {

        let name = packageName + "_" + packageName

        var candidates = [
            /* Bundle should be present here when the package is linked into an App. */
            Bundle.main.resourceURL,

            /* Bundle should be present here when the package is linked into a framework. */
            Bundle(for: CurrentBundleFinder.self).resourceURL,

            /* For command-line tools. */
            Bundle.main.bundleURL,
        ]

        #if DEBUG
        /* Bundle should be present here when running previews from a different package (this is the path to "…/Debug-iphonesimulator/"). */
        let debugCandidates = [
            Bundle(for: CurrentBundleFinder.self)
                .resourceURL?
                .deletingLastPathComponent()
                .deletingLastPathComponent()
                .deletingLastPathComponent(),

            Bundle(for: CurrentBundleFinder.self)
                .resourceURL?
                .deletingLastPathComponent()
                .deletingLastPathComponent(),
        ]

        candidates.append(contentsOf: debugCandidates)
        #endif

        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(name + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }

        fatalError("unable to find bundle named \(name)")
    }
}
