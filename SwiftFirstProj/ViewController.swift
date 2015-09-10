//
//  ViewController.swift
//  SwiftFirstProj
//
//  Created by 徐继垚 on 15/8/27.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource{
    var tableView : UITableView!
    var listVideos = NSMutableArray()
  
    override func viewDidLoad() {
        super.viewDidLoad()
          
    
        self.title = "电影"
         self.view.backgroundColor = UIColor.whiteColor()
        
        if listVideos.count == 0 {
            
            self.loadData()

        }
       self.didLoadView()

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func didLoadView() ->Void {
        
        tableView = UITableView(frame: CGRectMake(-15, 0, UIScreen.mainScreen().bounds.width + 15, UIScreen.mainScreen().bounds.height), style: UITableViewStyle.Grouped)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.registerClass(XUTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
    
        
    }
    
    func loadData() ->Void {
        
       VideoModel.loadVideoDataWithClouse { (dataArr) -> Void in
        
             self.listVideos = dataArr
        //     println(self.listVideos)
             self.tableView.reloadData()
        }
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return listVideos.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "cell"
        
        let cell: XUTableViewCell = tableView .dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! XUTableViewCell
        
         cell.drawCellWithModel(listVideos[indexPath.row] as! VideoModel)
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 100
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let model =  listVideos[indexPath.row] as! VideoModel
        
        let url = NSURL(string: model.video_url as String)
        
         let moviePlayer = MPMoviePlayerViewController(contentURL: url)
        
        self.presentMoviePlayerViewControllerAnimated(moviePlayer)
        
    }


    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.1
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

