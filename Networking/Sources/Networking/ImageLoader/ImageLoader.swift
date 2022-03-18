import Combine
import UIKit

public class ImageLoader {

    private(set) public var isLoading = false

    private var cache: ImageCache?
    private var cancellable: AnyCancellable?

    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")

    public init(cache: ImageCache?) {
        self.cache = cache
    }

    deinit {
        cancel()
    }

    public func load(_ url: URL, completion: @escaping (UIImage?) -> Void) {
        guard !isLoading else { return }

        if let image = cache?[url] {
            return completion(image)
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveOutput: { [weak self] in self?.cache($0, url: url) },
                          receiveCompletion: { [weak self] _ in self?.onFinish() },
                          receiveCancel: { [weak self] in self?.onFinish() })
            .subscribe(on: Self.imageProcessingQueue)
            .receive(on: DispatchQueue.main)
            .sink {
                completion($0)
            }
    }

    public func cancel() {
        cancellable?.cancel()
    }

    private func onStart() {
        isLoading = true
    }

    private func onFinish() {
        isLoading = false
    }

    private func cache(_ image: UIImage?, url: URL) {
        image.map { cache?[url] = $0 }
    }
}
