import SwiftUI

public class Navigation: ObservableObject {

    public init() {}

    @Published public var isPushed = false
    @Published public var isPresented = false
    @Published public var isCovered = false
    @Published public var destination: AnyView?
    @Published public var onDismiss: (() -> Void)?

    /// Presents to the destination view by the passed type (push, sheet or fullScreenCover)
    ///
    /// You can call this function directly from a navigation instance in the SwiftUI view.
    /// ```
    /// navigation.present(.push,
    ///                    destination: {
    ///                        Text("next screen")
    ///                    })
    ///
    /// navigation.present(.sheet,
    ///                    destination: { Text("next screen") },
    ///                    onDismiss: { isShow.toggle() }
    /// ```
    ///
    /// - Parameters:
    ///   - type: present type, can be one of ``NavigationType``.
    ///   - destination: a closure with a destination view to show.
    ///   - onDismiss: a callback when the presenting view be
    public func present<Destination: View>(_ type: NavigationType,
                                           @ViewBuilder destination: () -> Destination,
                                           onDismiss: (() -> Void)? = nil) {
        self.destination = AnyView(destination())
        switch type {
        case .push:
            self.onDismiss = onDismiss
            isPushed = true
        case .sheet:
            self.onDismiss = onDismiss
            isPresented = true
        case .fullScreenCover:
            self.onDismiss = onDismiss
            isCovered = true
        }
    }

    /// Manually dismiss the current presenting view.
    ///
    /// You can call this function directly from a navigation instance in the SwiftUI view.
    /// Normally, you will need the navigation from previour view (pass by EnvironmentObject)
    /// ```
    /// @EnvironmentObject var navigation: Navigation
    ///
    /// var body: some View {
    ///     Button {
    ///         navigation.dismiss()
    ///     } label: {
    ///         Text("Dismiss whole view")
    ///     }
    ///
    /// ```
    public func dismiss() {
        if isPushed {
            isPushed = false
        } else if isPresented {
            isPresented = false
        } else if isCovered {
            isCovered = false
        }
    }

}
