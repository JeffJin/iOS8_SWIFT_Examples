//
//  MusicService.swift
//  Chinook
//
//  Created by Jeff Jin on 2015-01-12.
//  Copyright (c) 2015 Jeff Jin. All rights reserved.
//

import UIKit
import AVFoundation

class MusicService {
   
    func getPlayer(file : String) ->AVAudioPlayer {
        
        var audioPath = NSString(string: NSBundle.mainBundle().pathForResource(file, ofType: "mp3")!)
        
        println(audioPath)
        
        var error : NSError? = nil
        var player = AVAudioPlayer(contentsOfURL: NSURL(string: audioPath), error: &error)
        
        return player
    }
}


