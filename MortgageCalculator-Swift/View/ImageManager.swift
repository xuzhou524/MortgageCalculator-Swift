//
//  ImageManager.swift
//  AsyncDisplayKit-Issue-2
//
//  Created by 崔 明辉 on 15/11/24.
//  Copyright © 2015年 AsyncDisplayKit. All rights reserved.
//

import UIKit
import AsyncDisplayKit


class ImageManager: NSObject, ASImageDownloaderProtocol, ASImageCacheProtocol {
    
    static let sharedManager = ImageManager()
    
    func fetchCachedImageWithURL(URL: NSURL!, callbackQueue: dispatch_queue_t!, completion: ((CGImage!) -> Void)!) {
        SDWebImageManager.sharedManager().cachedImageExistsForURL(URL) { (existed) -> Void in
            if existed {
                SDWebImageManager.sharedManager().downloadImageWithURL(URL, options: [], progress: nil, completed: { (cachedImage, _, _, _, _) -> Void in
                    dispatch_async(callbackQueue, { () -> Void in
                        if let image = cachedImage {
                            if let cImage = image.CGImage {
                                dispatch_async(callbackQueue, { () -> Void in
                                    completion(cImage)
                                })
                                return
                            }
                        }
                        completion(nil)
                    })
                })
            }
            else {
                dispatch_async(callbackQueue, { () -> Void in
                    completion(nil)
                })
            }
        }
    }
    
    func downloadImageWithURL(URL: NSURL!, callbackQueue: dispatch_queue_t!, downloadProgressBlock: ((CGFloat) -> Void)!, completion: ((CGImage!, NSError!) -> Void)!) -> AnyObject! {
        print(URL)
        let operation = SDWebImageDownloader.sharedDownloader().downloadImageWithURL(URL, options: [], progress: nil) { (image, data, error, _) -> Void in
            if let image = image {
                if let cImage = image.CGImage {
                    dispatch_async(callbackQueue, { () -> Void in
                        completion(cImage, error)
                    })
                    return
                }
            }
            completion(nil, error)
        }
        return operation
    }
    
    func cancelImageDownloadForIdentifier(downloadIdentifier: AnyObject!) {
        if let downloadIdentifier = downloadIdentifier as? SDWebImageOperation {
            downloadIdentifier.cancel()
        }
    }
    
}
