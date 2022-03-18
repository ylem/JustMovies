import SwiftUI
import Assets

public struct ProfileBarViewModifier: ViewModifier {

    private let isClickedProfile: Binding<Bool>

    public init(isClickedProfile: Binding<Bool>) {
        self.isClickedProfile = isClickedProfile
    }

    public func body(content: Content) -> some View {
        NavigationView {
            content
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Hello")
                            .foregroundColor(.white)
                            .font(.headline)
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isClickedProfile.wrappedValue.toggle()
                        } label: {
                            Image(uiImage: AppImage.gamer.image)
                                .resizable()
                                .frame(width: 30, height: 30)
                        }

                    }
                }
                .sheet(isPresented: isClickedProfile) {
                    VStack {
                        Text("Imagine this is a nice designed profile page :D")
                            .font(.title)
                            .foregroundColor(.green)

                        Spacer()
                    }
                    .padding(80)
                }
        }
    }
}

extension View {

    public func profileBarStyle(isClickedProfile: Binding<Bool>) -> some View {
        self.modifier(ProfileBarViewModifier(isClickedProfile: isClickedProfile))
    }
}
