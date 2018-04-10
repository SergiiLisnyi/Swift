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
        case subtract
        case multiple
        case divide
        case percent
        case xy
        case x2
        case x3
        case sin
        case cos
        case tan
        case ctan
        case ey
    }

    final let valueE = 2.71828182846
    
    var numberOnDisplay: Double {
        get {
            if let input = displayLabel.text , let result = Double(input){
            return result
            }
            return 0
        }
        set {
            displayLabel.text = newValue.truncatingRemainder(dividingBy: 1.0) == 0 ? String(format: "%.0f", newValue) : String(newValue)
        }
    }
    
    var previosNumber = 0.0
    var isOperationProgress = false
    var isOperationDone = false
    var operation: Int!
    
    @IBOutlet weak var displayLabel: UILabel!

    @IBAction func acButton(_ sender: Any) {
        numberOnDisplay = 0
        previosNumber = 0
        operation = nil
        isOperationProgress = false
        isOperationDone = false
    }
    
    @IBAction func onButtonDigitsTapped(_ sender: UIButton) {
        
        guard let title = sender.currentTitle, let number = Double(title) else{
            return
        }
        
        guard !isOperationDone else {
            isOperationDone = false
            onButtonDigitsTapped(sender)
            return
        }
        
        if isOperationProgress {
            numberOnDisplay = number
            isOperationProgress = false
        } else {
            numberOnDisplay = numberOnDisplay * 10 + number
        }
    }
    
    func mathOperation(_ firstOperand: Double, _ secondOperand: Double, _ operation: Operation) -> Double! {
        switch operation {
        case .add:
            return firstOperand + secondOperand
        case .subtract:
            return firstOperand - secondOperand
        case .multiple:
            return firstOperand * secondOperand
        case .divide:
            return firstOperand / secondOperand
        case .xy:
            return pow(firstOperand, secondOperand)
        case .x2:
            return pow(firstOperand, 2)
        case .x3:
            return pow(firstOperand, 3)
        case .sin:
            return sin(firstOperand * .pi / 180)
        case .cos:
            return cos(firstOperand * .pi / 180)
        case .tan:
            return tan(firstOperand * .pi / 180)
        case .ctan:
            return pow(tan(firstOperand * .pi / 180), -1)
        case .ey:
            return pow(valueE, firstOperand)
        default:
            return nil
        }
    }
    
    @IBAction func onButtonEqualTapped(_ sender: UIButton) {
    
        if operation != nil {
            let operation = Operation(rawValue: self.operation)!
            numberOnDisplay = mathOperation(previosNumber, numberOnDisplay, operation)
        }
        isOperationDone = true
        isOperationProgress = false
        previosNumber = numberOnDisplay
        operation = nil
    }
    
    @IBAction func onButtonOperationTapped(_ sender: UIButton) {
        if  !isOperationProgress {
            onButtonEqualTapped(sender)
        }
        operation = sender.tag
        isOperationProgress = true
    }
    
    @IBAction func onButtonUnaryTapped(_ sender: UIButton) {
        guard let operation = Operation(rawValue: sender.tag) else {
            return
        }
        numberOnDisplay = mathOperation(numberOnDisplay, previosNumber, operation)
    }
    
}
    


