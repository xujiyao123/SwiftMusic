//
//  MusicListViewController.swift
//  SwiftFirstProj
//
//  Created by 徐继垚 on 15/8/28.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

import UIKit

class MusicListViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource , UITextFieldDelegate{

    var tableView:UITableView!
    var dataSources = NSMutableArray()
    var textFild : UITextField!
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "音乐"
        
        
       
        
        self.didLoadView()
        if dataSources.count == 0 {
            self.loadData(1)
        }
        
        

        // Do any additional setup after loading the view.
    }
    func loadData(page:Int?) ->Void {
        
        if (textFild.text!.isEmpty) {
            textFild.text = "田馥甄"
        }
        
   MusicModel.loadMusicListDataWithClouse(textFild.text!, page: page!) { (data, haveNext) -> Void in
    
    self.dataSources.addObjectsFromArray(data as [AnyObject] )
    self.tableView.reloadData()
    if haveNext == 0 {
        self.tableView.endLoadMoreData()
    }
    else
    {
    self.tableView.doneRefresh()
    }
    
    
        }
       
        
        
    }
    
    
    func didLoadView() -> Void {

        tableView = UITableView(frame: CGRectMake(-15 ,0,   UIScreen.mainScreen().bounds.width + 15,   UIScreen.mainScreen().bounds.height) ,style:UITableViewStyle.Grouped)
               tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(XUTableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.toLoadMoreAction { () -> Void in
            self.page++
              self.loadData(self.page)
        }
        tableView.toRefreshAction { () -> Void in
            self.loadData(self.page)
        }
        
        self.view.addSubview(tableView)
        
    
        
        
        
        
      let  bacview = UIView(frame: CGRectMake(40, 0, 260, 44))
        self.navigationItem.titleView = bacview
        
        textFild = UITextField(frame: CGRectMake(40, 5, 250, 35))
        textFild.borderStyle = UITextBorderStyle.RoundedRect
        textFild.placeholder = "搜索"
        textFild.textAlignment = NSTextAlignment.Center
        textFild.delegate = self
        textFild.keyboardAppearance = UIKeyboardAppearance.Dark
        textFild.returnKeyType = UIReturnKeyType.Search
        bacview.addSubview(textFild)
        
     
        
    }
 
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textFild.resignFirstResponder()
        self.dataSources.removeAllObjects()
        self.loadData(1)
    
             return true
    }
 

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! XUTableViewCell
        
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
        
        let vc = MusicViewController()
        
        let model = dataSources[indexPath.row] as! MusicModel
        
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
