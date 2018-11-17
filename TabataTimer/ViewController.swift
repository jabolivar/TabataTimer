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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func startButton(_ sender: Any) {
        let minutes = minuteField.integerValue
        let seconds = secondField.integerValue
        if (minutes>=0 && seconds>0) || (minutes>0 && seconds>=0){
            let interval = "\(minutes):\(seconds)"
            intervalLabel.stringValue = interval
            // change start by pause
        }
    }
    
    @IBAction func resetButton(_ sender: Any) {
        clearText(field: minuteField)
        clearText(field: secondField)
        clearText(field: intervalLabel)
        clearText(field: totalLabel)
        
    }
    
    func clearText(field: NSTextField){
        field.stringValue = ""
    }
}

