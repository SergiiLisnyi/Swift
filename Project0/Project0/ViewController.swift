//
//  AppDelegate.swift
//  Project0
//
//  Created by Sergii Lisnyi on 4/3/18.
//  Copyright © 2018 Sergii Lisnyi. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    enum Operation: Int {
        case add = 12
        case subtract = 13
        case multiple = 14
        case divide = 15
        case percent = 16
        case sin = 30
        case cos = 31
        case tan = 32
        case ctan = 33
        
    }
    
//    enum Trigonometric: Int {
//        case sin = 30
//        case cos
//        case tan
//        case ctan
//    }
    
    
    
    var numberOnDisplay = 0.0
    var previosNumber = 0.0
    var operationDuring = false
    var operationDone = false
    var operationTrigonometric = false
    var operation = 0
    
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func acButton(_ sender: Any) {
        displayLabel.text = "0"
        previosNumber = 0
        operation = 0
        numberOnDisplay = 0
        operationDuring = false
        operationDone = false
    }
    
    @IBAction func onButtonDigitsTapped(_ sender: UIButton) {
        if  operationDone == false {
            if operationDuring == true {
                
                let result = testValueDisplay()
                if (result.hasPrefix("0.") == true) && (result.count == 2){
                    displayLabel.text = result + String(sender.tag)
                    numberOnDisplay = Double(testValueDisplay())!
                    operationDuring = false
                    return
                }
                displayLabel.text = String(sender.tag)
                numberOnDisplay = Double(testValueDisplay())!
                operationDuring = false
            } else {
                var result = testValueDisplay() + String(sender.tag)
                if (result.first == "0") && (result.contains(".") != true) {
                    result.removeFirst()
                }
                numberOnDisplay = Double(result)!
                displayLabel.text = String(result)
            }
        }
        else {
            operationDone = false
            onButtonDigitsTapped(sender)
        }
    }
    
    @IBAction func dot(_ sender: UIButton) {
        let displayText = testValueDisplay()
        if operationDuring == true {
            displayLabel.text = "0."
        }
         else if (displayText.contains(".")) {
            return
        }
        else {
            displayLabel.text = displayText + "."
        }
    }
    
    @IBAction func onButtonEqualTapped(_ sender: UIButton) {
        switch operation {
            case Operation.add.rawValue: displayLabel.text = resultString(previosNumber + numberOnDisplay)
            case Operation.subtract.rawValue: displayLabel.text = resultString(previosNumber - numberOnDisplay)
            case Operation.multiple.rawValue: displayLabel.text = resultString(previosNumber * numberOnDisplay)
            case Operation.divide.rawValue: displayLabel.text = resultString(previosNumber / numberOnDisplay)
            case Operation.percent.rawValue: displayLabel.text = resultString(previosNumber / numberOnDisplay * 100)
            case Operation.sin.rawValue: displayLabel.text = resultString(sin(numberOnDisplay * .pi / 180))
            case Operation.cos.rawValue: displayLabel.text = resultString(cos(numberOnDisplay * .pi / 180))
            case Operation.tan.rawValue: displayLabel.text = resultString(tan(numberOnDisplay * .pi / 180))
            case Operation.ctan.rawValue: displayLabel.text = resultString((cos(numberOnDisplay * .pi / 180)) /
                                                                            (sin(numberOnDisplay * .pi / 180)))
            default: break
        }
        operationDone = true
        operationDuring = false
        previosNumber = Double(displayLabel.text!)!
        operation = 0
        }
    
    @IBAction func onButtonOperationTapped(_ sender: UIButton) {
        if  operationDuring == false {
            onButtonEqualTapped(sender)
        }
        operation = sender.tag
        operationDuring = true
    }
    
    
    @IBAction func onButtonTrigonometricTaped(_ sender: UIButton) {
        operationTrigonometric = true
        
            switch sender.tag {
                case Operation.sin.rawValue: displayLabel.text = "sin("
    
                default: break
        }
        operation = sender.tag
        operationDuring = true
    }
    
    
    @IBAction func onButtonExponentiationTapped(_ sender: UIButton) {
        //if  operationDuring == false {
            if sender.tag == 20 {
                displayLabel.text = resultString(numberOnDisplay * numberOnDisplay)
                //operationDone = true
            } else if sender.tag == 21 {
            displayLabel.text = resultString(numberOnDisplay * numberOnDisplay * numberOnDisplay)
            //operationDone = true
        }
       // }
    }
    
    
    
    func resultString(_ value : Double) -> String {
        return value.truncatingRemainder(dividingBy: 1.0) == 0 ? String(format: "%.0f", value) : String(value)
    }
    
    func testValueDisplay() -> String {
        if let displayText = displayLabel.text {
            return displayText
        }
        return ""
    }
}

