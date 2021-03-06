//
//  InterfaceController.swift
//  Calculator WatchKit Extension
//
//  Created by Shanmathi Mayuram Krithivasan on 9/16/15.
//  Copyright © 2015 Shanmathi Mayuram Krithivasan. All rights reserved.
//

import WatchKit
import Foundation

enum modes{
    case NOT_SET
    case ADDITION
    case SUBTRACTION
}

class InterfaceController: WKInterfaceController {
    
    var labelString:String = "0"
    var currentMode:modes = modes.NOT_SET
    var savedNum:Int64 = 0
    var lastButtonWasMode:Bool = false
    
    
    @IBOutlet var label: WKInterfaceLabel!
    @IBAction func tapped0() {tappedNumber(0)}
    @IBAction func tapped1() {tappedNumber(1)}
    @IBAction func tapped2() {tappedNumber(2)}
    @IBAction func tapped3() {tappedNumber(3)}
    @IBAction func tapped4() {tappedNumber(4)}
    @IBAction func tapped5() {tappedNumber(5)}
    @IBAction func tapped6() {tappedNumber(6)}
    @IBAction func tapped7() {tappedNumber(7)}
    @IBAction func tapped8() {tappedNumber(8)}
    @IBAction func tapped9() {tappedNumber(9)}
    
    func tappedNumber(num:Int) {
        
        if lastButtonWasMode{
            lastButtonWasMode = false
            labelString = "0"
        }
        labelString = labelString.stringByAppendingString("\(num)")
        updateText()
    }
    
    func updateText() {
        guard let labelInt:Int64 = Int64(labelString) else {
            label.setText("number is too large")
            return
        }
        savedNum = (currentMode == modes.NOT_SET) ? labelInt : savedNum
        let formatter:NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let nsInt:NSNumber = NSNumber(longLong: labelInt)
        let str:String = formatter.stringFromNumber(nsInt)!
        label.setText("\(str)")
    }
    @IBAction func tappedPlus(){
        changeMode(modes.ADDITION)
    }
    
    @IBAction func tappedMinus(){
        changeMode(modes.SUBTRACTION)
    }
    
    func changeMode(newMode:modes){
        if savedNum == 0 {
            return
        }
        currentMode = newMode
        lastButtonWasMode = true
    }
    
    @IBAction func tappedClear(){
        savedNum = 0
        labelString = "0"
        label.setText("0")
        currentMode = modes.NOT_SET
        lastButtonWasMode = false
        
    }
    
    @IBAction func tappedEquals(){
        guard let num:Int64 = Int64(labelString) else {
            return
        }
        if currentMode == modes.NOT_SET || lastButtonWasMode {
            return
        }
        if currentMode == modes.ADDITION {
            savedNum += num
        }
        else if currentMode == modes.SUBTRACTION{
            savedNum -= num
        }
        currentMode = modes.NOT_SET
        labelString = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
    }

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
