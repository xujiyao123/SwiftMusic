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
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            
            if urlStr == nil {
                return
            }
            else
            {
             var url = NSURL(string: urlStr!)
            
            var imageData = NSData(contentsOfURL: url!)
            
            var image = UIImage(data: imageData!)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
                    if (image != nil) {
                        self.image = image
                    }
                
            })
            }
        })

        
        
        
        
        
    }
    
    
    
    
    
}