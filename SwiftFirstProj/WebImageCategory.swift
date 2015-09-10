//
//  WebImageCategory.swift
//  SwiftFirstProj
//
//  Created by 徐继垚 on 15/8/28.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    
    func setWebImageWithUrlStr(urlStr:String?) ->Void {
        
         self.image = UIImage(named: "1.jpg")
        
        
        let url = NSURL(string: urlStr!)
        
        let request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (respone, imagedata, contenterror) -> Void in
            
            let image = UIImage(data: imagedata!)
            
            if (image != nil){
                self.image = image
            }
            
            
        }
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
//            
//            let url = NSURL(string: urlStr!)
//            
//            let imageData = NSData(contentsOfURL: url!)
//            if imageData != nil {
//            let image = UIImage(data: imageData!)
//            
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//            
//                    if (image != nil) {
//                        self.image = image
//                    }
//                
//            })
//            }
//        })
        
    }
    
    
    
    
    
}