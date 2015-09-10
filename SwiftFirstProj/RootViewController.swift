//
//  RootViewController.swift
//  SwiftFirstProj
//
//  Created by 徐继垚 on 15/8/27.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

     var button: UIButton!
    var button2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.86, green:0.24, blue:0.22, alpha:1)
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        
        
        
        button = UIButton(frame: CGRectMake(0, 70, UIScreen.mainScreen().bounds.size.width, 50))
        button.backgroundColor = UIColor.redColor()
        button.setTitle("音乐", forState:UIControlState.Normal)
        button.addTarget(self, action: Selector("buttonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
        
        button2 = UIButton(frame: CGRectMake(0, 130, button.bounds.width, 50))
        button2.backgroundColor = UIColor.redColor()
        button2.setTitle("电影", forState: UIControlState.Normal)
        button2.addTarget(self, action: Selector("buttonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button2)
        // Do any additional setup after loading the view.
    }

    func buttonAction(sender: UIButton){
        
        if sender == button2{
            
            let vc:ViewController = ViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
           
            let vc:MusicListViewController = MusicListViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
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
