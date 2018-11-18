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
    @IBOutlet weak var startButton: NSButton!
    @IBOutlet weak var secondField: NSTextField!
    @IBOutlet weak var intervalLabel: NSTextField!
    @IBOutlet weak var totalLabel: NSTextField!
    @IBOutlet weak var repeatCheck: NSButton!
    @IBOutlet weak var resetButton: NSButton!
    var interval:TimeInterval = 0
    var countdown:TimeInterval = 0
    var total:TimeInterval = 0
    var timer = Timer()

    @IBAction func startButton(_ sender: Any) {
        if(self.startButton.title == "START"){
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
                self.startButton.title = "PAUSE"
                self.resetButton.isEnabled = true
            }
        }
        else if (self.startButton.title == "PAUSE"){
            timer.invalidate()
            self.startButton.title = "RESUME"
        }
        else{
            runTimer(intervals: 1)
            self.startButton.title = "PAUSE"
        }
    }
    
    func runTimer(intervals: int_fast8_t) {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(intervals), target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if countdown > 0 {
            countdown -= 1
        } else {
            if (repeatCheck.state == .on){
                countdown = interval
            } else {
                NSSound.glass?.play()
            }
        }
        intervalLabel.stringValue = intervalTimeString(time: countdown) //This will update the label.
        total += 1
        totalLabel.stringValue = totalTimeString(time: total) //This will update the label.
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
        let answer = dialogOKCancel(question: "Reset all timers?", text: "")
        if (answer){
            timer.invalidate()
            minuteField.isEnabled = true
            secondField.isEnabled = true
            clearText(field: minuteField)
            clearText(field: secondField)
            clearText(field: intervalLabel)
            clearText(field: totalLabel)
            self.startButton.title = "START"
            self.resetButton.isEnabled = false
        }
    }
    
    func clearText(field: NSTextField){
        field.stringValue = ""
    }
    
    func dialogOKCancel(question: String, text: String) -> Bool {
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        return alert.runModal() == .alertFirstButtonReturn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resetButton.isEnabled = false
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}

