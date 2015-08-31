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
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            
            var url = NSURL(string: urlStr!)
            
            var imageData = NSData(contentsOfURL: url!)
            if imageData != nil {
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