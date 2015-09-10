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
    
        let urlStr = "http://h5.kaolafm.com/v3api/api/search?words=\(searchStr)&pageSize=30&pageNum=\(page)&searchType=0&_=1419749689828"
        let url = NSURL(string: urlStr.stringByAddingPercentEncodingWithAllowedCharacters(
            NSCharacterSet(charactersInString: "").invertedSet)!)
        

        
       print(url)
        
        let urlRequest = NSMutableURLRequest(URL: url!)
        
        urlRequest.timeoutInterval = 10.0
        urlRequest.HTTPMethod = "GET"
        urlRequest.cachePolicy = NSURLRequestCachePolicy.UseProtocolCachePolicy
        
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (respons, data, connectionError) -> Void in
            
            if (connectionError == nil) {
                let jsonObject : AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                
                let dic = jsonObject.objectForKey("result") as! NSDictionary
                let next = dic.objectForKey("haveNext") as! Int
                
               let dataList = dic.objectForKey("dataList") as! NSMutableArray
                
                let dataSources = NSMutableArray()
                
                for result in dataList {
                    let model = MusicModel()
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
        
    
        
        let urlStr = "http://v3.kaolafm.com/api/play/\(musicID)"
        let url = NSURL(string: urlStr.stringByAddingPercentEncodingWithAllowedCharacters(
            NSCharacterSet(charactersInString: "").invertedSet)!)

        
        let urlRequest = NSMutableURLRequest(URL: url!)
        
        urlRequest.timeoutInterval = 10.0
        urlRequest.HTTPMethod = "GET"
        urlRequest.cachePolicy = NSURLRequestCachePolicy.UseProtocolCachePolicy
        
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (respons, data, connectionError) -> Void in
            
            if (connectionError == nil) {
                
                    let jsonObject : AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                
                
                let dic = jsonObject.objectForKey("result") as! NSDictionary
                let dataSources = NSMutableArray()
                
                let model = MusicPlayModel()
                model.title = dic.objectForKey("title") as? String
                model.pic = dic.objectForKey("pic") as? String
                model.mp3Url = dic.objectForKey("mp3PlayUrl") as! String
                
                dataSources.addObject(model)
                clouse(data: dataSources)
            }
            
        }
        
    }
    
    
    
}
    
    
    
    
    
    
    
    
    









