//
//  ViewController.swift
//  TabataTimer
//
//  Created by Juan Bolívar on 11/17/18.
//  Copyright © 2018 Oneware.co. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var minuteField: NSTextField!
    @IBOutlet weak var secondField: NSTextField!
    @IBOutlet weak var intervalLabel: NSTextField!
    @IBOutlet weak var totalLabel: NSTextField!
    @IBOutlet weak var startButton: NSButton!
    var interval:TimeInterval = 0
    var countdown:TimeInterval = 0
    var total:TimeInterval = 0
    var timer = Timer()
    var isTimerRunning = false

    @IBAction func startButton(_ sender: Any) {
        if(startButton.title == "Start"){
            let minutes = minuteField.integerValue
            let seconds = secondField.integerValue
            if (minutes>=0 && seconds>0) || (minutes>0 && seconds>=0){
                minuteField.isEnabled = false
                secondField.isEnabled = false
                interval = TimeInterval(minutes*60+seconds)
                countdown = interval
                total = 0
                //intervalLabel.stringValue = interval
                runTimer(intervals: 1)
                startButton.title = "Pause"
            }
        }
        else if (startButton.title == "Pause"){
            timer.invalidate()
            startButton.title = "Resume"
        }
        else{
            runTimer(intervals: 1)
            startButton.title = "Pause"
        }
    }
    
    func runTimer(intervals: int_fast8_t) {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(intervals), target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if countdown < 1 {
            
            countdown = interval
            //Send alert to indicate "time's up!"
        } else {
        countdown -= 1     //This will decrement(count down)the seconds.
        total += 1
        intervalLabel.stringValue = intervalTimeString(time: countdown) //This will update the label.
        totalLabel.stringValue = totalTimeString(time: total) //This will update the label.
        }
    }
    
    func intervalTimeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    func totalTimeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    @IBAction func resetButton(_ sender: Any) {
        //ask for confirmation
        timer.invalidate()
        minuteField.isEnabled = true
        secondField.isEnabled = true
        clearText(field: minuteField)
        clearText(field: secondField)
        clearText(field: intervalLabel)
        clearText(field: totalLabel)
        startButton.title = "Start"
    }
    
    func clearText(field: NSTextField){
        field.stringValue = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}

