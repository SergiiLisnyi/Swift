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
        case Add = 12
        case Subtract
        case Multiple
        case Divide
        case Percent
    }
    
    var numberOnDisplay = 0.0
    var previosNumber = 0.0
    var operationDuring = false
    var operationDone = false
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
                displayLabel.text = String(sender.tag)
                numberOnDisplay = Double(testValueDisplay())
                operationDuring = false
            } else {
                let result = testValueDisplay() * 10 + sender.tag
                numberOnDisplay = Double(result)
                displayLabel.text = String(result)
            }
        }
        else {
            operationDone = false
            onButtonDigitsTapped(sender)
        }
    }
    
    @IBAction func onButtonEqualTapped(_ sender: UIButton) {
        switch operation {
            case Operation.Add.rawValue: displayLabel.text = String(previosNumber + numberOnDisplay)
            case Operation.Subtract.rawValue: displayLabel.text = String(previosNumber - numberOnDisplay)
            case Operation.Multiple.rawValue: displayLabel.text = String(previosNumber * numberOnDisplay)
            case Operation.Divide.rawValue: displayLabel.text = String(previosNumber / numberOnDisplay)
            case Operation.Percent.rawValue: displayLabel.text = String(previosNumber / numberOnDisplay * 100)
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
    
    func testValueDisplay() -> Int {
        if let displayText = displayLabel.text, let displayInt =  Int(displayText), displayInt < Int.max / 10 {
            return displayInt
        }
        return 0
    }
}

