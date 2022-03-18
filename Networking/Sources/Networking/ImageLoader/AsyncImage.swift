import SwiftUI

public struct AsyncImage<Placeholder: View>: View {

    private let url: URL?
    private var loader: ImageLoader
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image

    /// Variable to check if the image has been loaded yet
    @State private var isLoading: Bool = false
    @State private var loadedImage: UIImage?

    public init(
        url: URL?,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ) {
        self.url = url
        self.placeholder = placeholder()
        self.image = image

        loader = ImageLoader(cache: Environment(\.imageCache).wrappedValue)
    }

    private func loadImage() {
        guard let url = url else { return }
        isLoading = true
        loader.load(url) { uiImage in
            self.loadedImage = uiImage
            isLoading = false
        }
    }

    public var body: some View {
        Group {
            if loadedImage != nil {
                // If there is an image to display, show it.
                image(loadedImage!)
            } else if isLoading {
                // If loading an image, show the placeholder.
                placeholder
            } else {
                // If finished loading and no image found, display error
                #warning("Asyncimage: Generate a failed to load warning image")
                HStack {
                    Text("Could not load image")
                }
            }
        }
        .onAppear {
            loadImage()
        }
    }
}
