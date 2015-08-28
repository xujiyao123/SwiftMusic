//
//  MusicListViewController.swift
//  SwiftFirstProj
//
//  Created by 徐继垚 on 15/8/28.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

import UIKit

class MusicListViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource{

    var tableView:UITableView!
    var dataSources = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "音乐"
        
        
        if dataSources.count == 0 {
            self.loadData()
        }
        
        self.didLoadView()
        
        
        

        // Do any additional setup after loading the view.
    }
    func loadData() ->Void {
        
        MusicModel.loadMusicListDataWithClouse { (data) -> Void in
            
            self.dataSources = data
            self.tableView.reloadData()
        }
        
        
    }
    
    func didLoadView() -> Void {
        tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(XUTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! XUTableViewCell
        
        cell.drawMusicWithModel(dataSources[indexPath.row] as! MusicModel)
        
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var vc = MusicViewController()
        
        var model = dataSources[indexPath.row] as! MusicModel
        
        vc.musicID = model.oid
        
       self.navigationController?.pushViewController(vc, animated: false)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
