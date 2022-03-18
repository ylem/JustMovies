import SwiftUI

public extension View {
    func fillParent(alignment: Alignment = .center) -> some View {
        self
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: alignment
            )
    }

    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil,
                                        from: nil,
                                        for: nil)
    }
}

/// Placehoder modifier
public extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }

    func placeholder(
        _ text: String,
        when shouldShow: Bool,
        alignment: Alignment = .leading
    ) -> some View {
        placeholder(when: shouldShow, alignment: alignment) { Text(text).foregroundColor(.gray) }
    }
}
