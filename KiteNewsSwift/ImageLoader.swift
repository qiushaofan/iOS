//
//  ImageLoader.swift
//  KiteNewsSwift
//
//  Created by 邱少藩 on 16/5/22.
//  Copyright © 2016年 邱少藩. All rights reserved.
//

import UIKit
import Foundation


class ImageLoader {
    
    let cache = NSCache()
    
    class var sharedLoader : ImageLoader {
        struct Static {
            static let instance : ImageLoader = ImageLoader()
        }
        return Static.instance
    }
    
    func imageForUrl(urlString: String, completionHandler:(image: UIImage?, url: String) -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {()in
            let data: NSData? = self.cache.objectForKey(urlString) as? NSData
            
            if let goodData = data {
                let image = UIImage(data: goodData)
                dispatch_async(dispatch_get_main_queue(), {() in
                    completionHandler(image: image, url: urlString)
                })
                return
            }
            
            let downloadTask: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!, completionHandler: {(data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                if (error != nil) {
                    completionHandler(image: nil, url: urlString)
                    return
                }
                
                if let data = data {
                    let image = UIImage(data: data)
                    self.cache.setObject(data, forKey: urlString)
                    dispatch_async(dispatch_get_main_queue(), {() in
                        completionHandler(image: image, url: urlString)
                    })
                    return
                }
                
            })
            downloadTask.resume()
        })
        
    }
    
    func imageForUrls(urlStrings: NSArray, completionHandler:(image: UIImage?, url: String,index: Int) -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {()in
            for i in 0..<urlStrings.count
            {
                let data: NSData? = self.cache.objectForKey(urlStrings[i]) as? NSData
                
                if let goodData = data {
                    let image = UIImage(data: goodData)
                    dispatch_async(dispatch_get_main_queue(), {() in
                        completionHandler(image: image, url: urlStrings[i] as! String,index:i)
                    })
                    
                    continue
                }
                
                let downloadTask: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlStrings[i] as! String)!, completionHandler: {(data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                    if (error != nil) {
                        completionHandler(image: nil, url: urlStrings[i] as! String,index:i)
                        return
                    }
                    
                    if let data = data {
                        let image = UIImage(data: data)
                        self.cache.setObject(data, forKey: urlStrings[i])
                        dispatch_async(dispatch_get_main_queue(), {() in
                            completionHandler(image: image, url: urlStrings[i] as! String,index:i)
                        })
                        return
                    }
                    
                })
                downloadTask.resume()
            }
            
        })
        
    }
    
}