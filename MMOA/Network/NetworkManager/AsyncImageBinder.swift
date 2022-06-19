//
//  AsyncImageBinder.swift
// 

import Foundation
import Combine
import UIKit
// 1 Here we have used ObservableObject protocol. This is the Combine way to make a model observable
class AsyncImageBinder: ObservableObject {
    private var subscription: AnyCancellable?
    private var cache = AsyncImageCache.shared

    // 2 We have used Published property wrapper with image property. It will notify the subscriber, whenever we will update the value of the image.
    @Published private(set) var image: UIImage?
    // 3 load(url:) method will fetch the image from the remote URL.
    func load(urlString: String) {
        /**
         1- dataTaskPublisher(for url: URL) will give us URLSession.DataTaskPublisher. We know, each publisher has two associated types. They are Output and Failure(error). So, the Output of URLSession.DataTaskPublisher has data and response. We need to manipulate the data. So we have introduced a series of operations on this publisher.
         2- map will try to get the UIImage from the data.
         3- If we are unable to fetch the image data and ended up with an error, replaceError(with:) will replace the error with nil.
         4- As per Multithreading rules, we should update UI on the main thread only. So here we will receive on the main thread.
         5- Here we will assign the received value to image property.
         */
        guard let url = URL(string: urlString) else {
            return image = nil
        }
        if let image: UIImage = cache[url.absoluteString] {
                self.image = image
                return
        }else{
            subscription = URLSession.shared
                                   .dataTaskPublisher(for: url)      // 1
                                   .map { UIImage(data: $0.data) }   // 2
                                   .replaceError(with: nil)          // 3
                                   .receive(on: DispatchQueue.main)  // 4
                                   .assign(to: \.image, on: self)    // 5
        }
            
       
    }
    // 4 cancel method will cancel the subscription when we don’t want to render the image in the UI.
    func cancel() {
        subscription?.cancel()
    }
}


class AsyncImageCache {
    
    // 1
    static let shared = AsyncImageCache()
    // 2
    private var cache: NSCache = NSCache<NSString, UIImage>()
    // 3
    subscript(key: String) -> UIImage? {
        get { cache.object(forKey: key as NSString) }
        set(image) { image == nil ? self.cache.removeObject(forKey: (key as NSString)) : self.cache.setObject(image!, forKey: (key as NSString)) }
    }
}
