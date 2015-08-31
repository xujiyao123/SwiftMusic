//
//  MusicPlayerManager.swift
//  SwiftFirstProj
//
//  Created by 徐继垚 on 15/8/28.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

import UIKit
import AVFoundation

protocol MusicPlayerDelegate : NSObjectProtocol {
    
    func playManager(manager:MusicPlayerManager ,BeginToPlayProgress progress:Double)
    
    func playManagerplayIsEnd(manager:MusicPlayerManager)
    
    func playManagerplayIsPause(manager:MusicPlayerManager )
    
    func playManagerplayIsGoOn(manager:MusicPlayerManager )
    
}

class MusicPlayerManager: NSObject {
    
    var delegate: MusicPlayerDelegate?
    var player: AVPlayer!
    
    var timer:NSTimer!
    
    class var shared: MusicPlayerManager {
        if !(Inner.instance != nil) {
            Inner.instance = MusicPlayerManager()
        }
        return Inner.instance!
    }
    
    struct Inner {
        static var instance: MusicPlayerManager?
    }
   
    
    func playWithModel(model:MusicPlayModel) {
        
       var url = NSURL(string: model.mp3Url)
        
        
        player = AVPlayer(URL: url)
        
        player.play()
        
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("playing"), userInfo: nil, repeats: true)
        
    }
    func playing() {
        
        
        if ((CMTimeGetSeconds(player.currentItem.duration) - CMTimeGetSeconds(player.currentItem.currentTime())) != 0) {
            
            var currentTime = CMTimeGetSeconds(player.currentItem.currentTime());
            var durationTime = CMTimeGetSeconds(player.currentItem.duration);
            
         var  percentage = (CMTimeGetSeconds(player.currentItem.currentTime())/CMTimeGetSeconds(player.currentItem.duration));
            
                delegate?.playManager(self, BeginToPlayProgress: percentage)
            
        
        }
        if( CMTimeGetSeconds(player.currentItem.duration) - CMTimeGetSeconds(player.currentItem.currentTime()) < 1 ){
            
            
            timer.invalidate()
                 delegate?.playManagerplayIsEnd(self)
          
            
        }
        
    }
    
    
    
    func pause() {
        
      player.pause()
        
        delegate?.playManagerplayIsPause(self)
        
    }
    func goon() {
        
        player.play()
        
        delegate?.playManagerplayIsGoOn(self)
    }
    

    
    func changeValueWithProgress(value:Float64) ->Void {
    
    var timer = self.player.currentItem.asset.duration.timescale;
    
    var timeValue = CMTimeGetSeconds(self.player.currentItem.duration) * value;
    player.seekToTime(CMTimeMakeWithSeconds(timeValue, timer), toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
        
    }
    
    
    
    
    
    
    
    
    
    
}
