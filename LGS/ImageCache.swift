//
//  ImageCache.swift
//  LGS
//
//  Created by Эрик Вильданов on 21.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit

class ImageCache {
    
    static let sharedCache: NSCache = {
        let cache = NSCache()
        cache.name = "ImageCache"
        cache.countLimit = 50
        cache.totalCostLimit = 10*1024*1024 
        return cache
    }()
    
}

extension NSURL {
    
    typealias ImageCacheCompletion = UIImage -> Void
    
    var cachedImage: UIImage? {
        return ImageCache.sharedCache.objectForKey(
            absoluteString) as? UIImage
    }
    
    func fetchImage(completion: ImageCacheCompletion) {
        let task = NSURLSession.sharedSession().dataTaskWithURL(self) {
            data, _, error in
            if error == nil {
                if let  data = data,
                    image = UIImage(data: data) {
                    ImageCache.sharedCache.setObject(
                        image,
                        forKey: self.absoluteString,
                        cost: data.length)
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(image)
                    }
                }
            }
        }
        task.resume()
    }
    
}
