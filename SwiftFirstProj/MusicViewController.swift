//
//  MusicViewController.swift
//  SwiftFirstProj
//
//  Created by 徐继垚 on 15/8/28.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

import UIKit

class MusicViewController: UIViewController ,MusicPlayerDelegate{

    var musicID :String!
    var datasources = NSMutableArray()
    var picImageView: UIImageView!
    var playButton: UIButton!
    var pauseButton: UIButton!
    var vuleSilder: UISlider!
    
    var timer:NSTimer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        if datasources.count == 0 {
            
            self.loadData()
        }
        
      
        

        // Do any additional setup after loading the view.
    }
    func loadData() {
        
        MusicPlayModel.loadMusicDataWithClouse(musicID, clouse: { (data) -> Void in
            
            self.datasources = data
            
            var model = self.datasources[0] as! MusicPlayModel
         
            self.title = model.title
            self.didLoadView()
            
            self.playMusic(nil)
        })
        
        
    }
    
    
    func didLoadView() {
        var model = datasources[0] as! MusicPlayModel
        
       
        picImageView = UIImageView(frame: CGRectMake(0, 0, 340, 340))
        picImageView.center = self.view.center
        picImageView.layer.cornerRadius = 170
        picImageView.layer.masksToBounds = true
        picImageView.backgroundColor = UIColor.redColor()
        picImageView.contentMode = UIViewContentMode.ScaleAspectFill
        picImageView.setWebImageWithUrlStr(model.pic)
        picImageView.layer.shadowColor = UIColor.blackColor().CGColor
        picImageView.layer.shadowOffset = CGSizeMake(1, 1)
        self.view.addSubview(picImageView)
        
        
        playButton = UIButton(frame: CGRectMake(10, 74, 120, 30))
        playButton.setTitle("gogon", forState: UIControlState.Normal)
        playButton.backgroundColor = UIColor.redColor()
        playButton.addTarget(self, action: Selector("buttonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(playButton)
        
        pauseButton = UIButton(frame: CGRectMake(150, 74, 120, 30))
        pauseButton.setTitle("pause", forState: UIControlState.Normal)
        pauseButton.backgroundColor = UIColor.redColor()
        pauseButton.addTarget(self, action: Selector("buttonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(pauseButton)
            
        
       vuleSilder = UISlider(frame: CGRectMake(0, 530, UIScreen.mainScreen().bounds.width, 30))
        vuleSilder.addTarget(self, action: Selector("vuleAct:"), forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(vuleSilder)
       
        
        
    }
    func vuleAct(sender:UISlider) {
        
        var progers :NSString = "\(sender.value)"
        
        var float:Float64 = progers.doubleValue
        
        MusicPlayerManager.shared.changeValueWithProgress(float)
        
    }
    
    func playMusic(sender:UIButton?) {
        
        var model = datasources[0] as! MusicPlayModel

        MusicPlayerManager.shared.playWithModel(model)
       
        MusicPlayerManager.shared.delegate = self
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("move"), userInfo: nil, repeats: true)
        
    }
    func playManager(manager: MusicPlayerManager, BeginToPlayProgress progress: Double) {
        
        var doubleStr:NSString =  "\(progress)"
        
        vuleSilder.value = doubleStr.floatValue
    }
    func playManagerplayIsGoOn(manager: MusicPlayerManager) {
        println("goon")
    }
    func playManagerplayIsPause(manager: MusicPlayerManager) {
        println("pause")
    }
    func playManagerplayIsEnd(manager: MusicPlayerManager) {
        println("end")
    }
    
    
    func buttonAction(sender:UIButton) {
        
        if sender == pauseButton {
            
            MusicPlayerManager.shared.pause()
            self.timer.invalidate()
            
        }
        else
        {
            
            MusicPlayerManager.shared.goon()
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("move"), userInfo: nil, repeats: true)

        }
        
        
        
    }
    
    func move() {
        
    picImageView.transform = CGAffineTransformRotate(picImageView.transform,0.002);
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
