//
//  MusicModel.swift
//  SwiftFirstProj
//
//  Created by 徐继垚 on 15/8/28.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

import UIKit
//http://h5.kaolafm.com/v3api/api/search?words=%E5%91%A8%E6%9D%B0%E4%BC%A6&pageSize=30&pageNum=20&searchType=0&_=1419749689828

//http://v3.kaolafm.com/api/play/1000000940595
class MusicModel: NSObject {

    var img: String!
    var oid: String!
    var name: String!
    var cname:String!
    var haveNext:String!
    
    class func loadMusicListDataWithClouse(searchStr:String ,page:Int , clouse:(data:NSMutableArray , haveNext:Int) -> Void) -> Void {
    
        var urlStr = "http://h5.kaolafm.com/v3api/api/search?words=\(searchStr)&pageSize=30&pageNum=\(page)&searchType=0&_=1419749689828"
        var url = NSURL(string: urlStr.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)! )
        
       println(url)
        
        var urlRequest = NSMutableURLRequest(URL: url!)
        
        urlRequest.timeoutInterval = 10.0
        urlRequest.HTTPMethod = "GET"
        urlRequest.cachePolicy = NSURLRequestCachePolicy.UseProtocolCachePolicy
        
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (respons, data, connectionError) -> Void in
            
            if (connectionError == nil) {
                let jsonObject : AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
                
                var dic = jsonObject.objectForKey("result") as! NSDictionary
                var next = dic.objectForKey("haveNext") as! Int
                
               var dataList = dic.objectForKey("dataList") as! NSMutableArray
                
                var dataSources = NSMutableArray()
                
                for result in dataList {
                    var model = MusicModel()
                   model.img = result.objectForKey("img") as? String
                    model.oid = result.objectForKey("oid") as? String
                    model.name = result.objectForKey("name") as? String
                    model.cname = result.objectForKey("cname") as? String
                   dataSources.addObject(model)
                }
                
                
                
                
                clouse(data: dataSources, haveNext: next)
            }
            
        }
        
    }
    
    
}

class MusicPlayModel : NSObject {
    
    var title:String!
    var pic:String!
    var mp3Url: String!
    
    class func loadMusicDataWithClouse(musicID:String ,clouse:(data:NSMutableArray) -> Void) ->Void {
        
    
        
        var urlStr = "http://v3.kaolafm.com/api/play/\(musicID)"
        var url = NSURL(string: urlStr.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)! )
        
        var urlRequest = NSMutableURLRequest(URL: url!)
        
        urlRequest.timeoutInterval = 10.0
        urlRequest.HTTPMethod = "GET"
        urlRequest.cachePolicy = NSURLRequestCachePolicy.UseProtocolCachePolicy
        
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (respons, data, connectionError) -> Void in
            
            if (connectionError == nil) {
                let jsonObject : AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
                
                var dic = jsonObject.objectForKey("result") as! NSDictionary
                var dataSources = NSMutableArray()
                
                var model = MusicPlayModel()
                model.title = dic.objectForKey("title") as? String
                model.pic = dic.objectForKey("pic") as? String
                model.mp3Url = dic.objectForKey("mp3PlayUrl") as! String
                
                dataSources.addObject(model)
                clouse(data: dataSources)
            }
            
        }
        
    }
    
    
    
}
    
    
    
    
    
    
    
    
    









