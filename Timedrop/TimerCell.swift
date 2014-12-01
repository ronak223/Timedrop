//
//  TimerCell.swift
//  Timedrop
//
//  Created by Ronak Patel on 11/22/14.
//  Copyright (c) 2014 Ronak Patel. All rights reserved.
//

import UIKit

class TimerCell: UITableViewCell {

    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var timerTitle: UILabel!
    
    @IBOutlet weak var startButtonIconForButton: UIButton!
    
    
    var timer:NSTimer = NSTimer()
    
    var timerLength:Double = 0
    var currentTime:Double = 0
    
    var timerIsRunning = false
    
    //background task init
    var backgroundTask:UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        currentTime = timerLength
        calculateTimes()
        
        self.backgroundTask = UIBackgroundTaskInvalid
        
        println("Reinitializing cell nib")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //starting timer
    func startTimer(){
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTime", userInfo: nil, repeats: true)
    }
    
    //pausing timer
    func pauseTimer(){
        timer.invalidate()
    }
    
    //updating label for timer
    func updateTime(){
        currentTime -= timer.timeInterval
        if(currentTime <= 0){
            timer.invalidate()
            stopBackgroundTask()
            currentTime = 0
            timerLabel.text = "00:00:00"
        }
        else{
            calculateTimes()
        }
    }
    
    //setting time
    func setTimer(secondsOfTimer:Double){
        timerLength = secondsOfTimer
        resetTimer()
        
    }
    
    //resetting timer
    func resetTimer(){
        timer.invalidate()
        stopBackgroundTask()
        timerIsRunning = false
        currentTime = timerLength
        
        //changing backroung image to start button
        var startButtonImage = UIImage(named: "play-75.png")
        startButtonIconForButton.setBackgroundImage(startButtonImage, forState: UIControlState.Normal)
        
        calculateTimes()
    }
    
    //calculating hour, minute, and second for updating label
    func calculateTimes(){

        var hour:Int = Int(floor(currentTime / 3600))
        var remaining = currentTime % 3600
        var minute:Int = Int(floor(remaining / 60))
        var second:Int = Int(remaining % 60)
        
        timerLabel.text = NSString(format: "%02d:%02d:%02d", hour, minute, second)
    }
    
    //setting timer label
    func setTimerLabel(text:String){
        timerTitle.text = text
    }
    
    @IBAction func startButton(sender: UIButton) {
        if(timerIsRunning == false){
            startTimer()
            beginBackgroundTask()
            timerIsRunning = true
            
            //setting backround image to pause button
            var pauseButtonImage = UIImage(named: "pause-75.png")
            sender.setBackgroundImage(pauseButtonImage, forState: UIControlState.Normal)
        }
        else{
            //pause timer if timerIsRunning is true
            timer.invalidate()
            stopBackgroundTask()
            timerIsRunning = false
            
            //changing backroung image to start button
            var startButtonImage = UIImage(named: "play-75.png")
            sender.setBackgroundImage(startButtonImage, forState: UIControlState.Normal)
            
        }
        
        
    }
    
    func beginBackgroundTask(){
        //starting as background task
        self.backgroundTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({ () -> Void in
            println("Background Task handler called. No more background tasks")
            UIApplication.sharedApplication().endBackgroundTask(self.backgroundTask)
            self.backgroundTask = UIBackgroundTaskInvalid
        })
    }
    
    func stopBackgroundTask(){
        //stopping background task
        UIApplication.sharedApplication().endBackgroundTask(self.backgroundTask)
        self.backgroundTask = UIBackgroundTaskInvalid
    }
    
    @IBAction func resetButton(sender: UIButton) {
        timer.invalidate()
        resetTimer()
    }
    
    @IBAction func deleteButton(sender: UIButton) {
        
        //TODO: remove from global array and update table view
    }
}
