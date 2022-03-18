import SwiftUI
import Assets

public struct SearchBarProperties {
    let image: Image?
    let placeholder: String
    let keyboardType: UIKeyboardType
    let startEditing: (() -> Void)?
    let onCommit: (() -> Void)?
    let didCancel: (() -> Void)?

    public init(
        image: Image? = Image(systemName: "magnifyingglass"),
        placeholder: String = "Search...",
        keyboardType: UIKeyboardType = .webSearch,
        startEditing: (() -> Void)? = nil,
        onCommit: (() -> Void)? = nil,
        didCancel: (() -> Void)? = nil
    ) {
        self.image = image
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.startEditing = startEditing
        self.onCommit = onCommit
        self.didCancel = didCancel
    }
}

public struct SearchBar: View {

    @Binding var text: String
    private let properties: SearchBarProperties
    @State private(set) public var isEditing = false

    public init(
        text: Binding<String>,
        properties: SearchBarProperties = .init()
    ) {
        self._text = text
        self.properties = properties
    }

    public var body: some View {
        HStack(spacing: 8) {
            HStack(spacing: 0) {
                Group {
                    if let image = properties.image {
                        image
                            .foregroundColor(Color(AppColor.secondary.color))
                            .frame(minWidth: 24, maxWidth: 24, alignment: .leading)
                    } else {
                        Color.clear
                            .frame(maxWidth: 8, alignment: .leading)
                    }
                }
                .padding(.leading, 8)

                TextField("", text: $text, onCommit: {
                    properties.onCommit?()
                    dismissKeyboard()
                })
                .placeholder(properties.placeholder, when: text.isEmpty)
                .multilineTextAlignment(.leading)
                .font(.body)
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .accentColor(.white)
                .onTapGesture {
                    isEditing = true
                    properties.startEditing?()
                }
                .keyboardType(properties.keyboardType)

                if !text.isEmpty {
                    Button(action: {
                        cancellEditing()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                            .padding(.trailing, 8)
                    }
                }
            }
            .frame(height: 36)
            .background(Color.clear)
            .cornerRadius(18)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(AppColor.brandPrimary.color).opacity(0.6), lineWidth: 2)
            )

            if !text.isEmpty {
                Button(action: {
                    cancellEditing()
                }, label: {
                    Text("Cancel")
                        .font(.body)
                        .foregroundColor(Color(AppColor.brandPrimary.color))
                })
            }
        }
    }

    private func cancellEditing() {
        text = ""
        isEditing = false
        properties.didCancel?()
        dismissKeyboard()
    }
}
