//
//  VideoModel.swift
//  SwiftFirstProj
//
//  Created by 徐继垚 on 15/8/28.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

import UIKit

class VideoModel: NSObject {
   
    var video_img:NSString!
    var video_subTitle:NSString!
    var video_title:NSString!
    var video_url:NSString!
    
   
  class func loadVideoDataWithClouse(clouse:(dataArr:NSMutableArray) -> Void) -> Void{
    
     
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            
            let plistPath : String! = NSBundle.mainBundle().pathForResource("videos", ofType: "plist")
        
            var dataArray  = NSMutableArray(contentsOfFile: plistPath)
            
            var dataSources = NSMutableArray()
            
            for arr in dataArray! {
                
                var model = VideoModel()
                model.video_img = arr.objectForKey("video_img") as! String
                model.video_subTitle = arr.objectForKey("video_subTitle") as! String
                model.video_title = arr.objectForKey("video_title") as! String
                model.video_url = arr.objectForKey("video_url") as! String
                
                dataSources.addObject(model)
            }
            
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
            
                    clouse(dataArr:dataSources)
                
            })
            
        })
        
        
    }
    
    
}
