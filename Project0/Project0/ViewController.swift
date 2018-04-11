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
    
    enum ErrorMathOperation: Error {
        case divideByZero
        case noValueSomeTg
        case noValueSomeCtg
        case errorMath
        
        var description: String {
            switch self {
            case .divideByZero:
                return "Error: divede by zero"
            case .noValueSomeTg:
                return "Error: no value tg"
            case .noValueSomeCtg:
                return "Error: no value ctg"
            case .errorMath:
                return "Error"
            }
        }
    }

    final let valueE = 2.71828182846
    
    var valueOnDisplay: Double {
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
    
    var previousValue = 0.0
    var isOperationInProgress = false
    var operation: Operation?
    
    @IBOutlet weak var displayLabel: UILabel!

    @IBAction func acButton(_ sender: Any) {
        valueOnDisplay = 0
        previousValue = 0
        operation = nil
        isOperationInProgress = false
    }
    
    @IBAction func onButtonDigitsTapped(_ sender: UIButton) {
        
        guard let title = sender.currentTitle, let number = Double(title) else{
            return
        }
        
        if isOperationInProgress {
            valueOnDisplay = number
            isOperationInProgress = false
        } else {
            valueOnDisplay = valueOnDisplay * 10 + number
        }
    }
    
    func mathOperation(_ firstOperand: Double, _ secondOperand: Double, _ operation: Operation) throws -> Double? {
        switch operation {
        case .add:
            return firstOperand + secondOperand
        case .subtract:
            return firstOperand - secondOperand
        case .multiple:
            return firstOperand * secondOperand
        case .divide:
            guard secondOperand != 0 else {
                throw ErrorMathOperation.divideByZero
            }
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
            guard (firstOperand + 90).truncatingRemainder(dividingBy: 180) != 0 else {
                throw ErrorMathOperation.noValueSomeTg
            }
            return tan(firstOperand * .pi / 180)
        case .ctan:
            guard firstOperand != 0, firstOperand.truncatingRemainder(dividingBy: 180) != 0 else {
                throw ErrorMathOperation.noValueSomeCtg
            }
            return pow(tan(firstOperand * .pi / 180), -1)
        case .ey:
            return pow(valueE, firstOperand)
        default:
            return nil
        }
    }
    
    @IBAction func onButtonEqualTapped(_ sender: UIButton) {
    
        if let operation = operation {
            do {
                 valueOnDisplay = try mathOperation(previousValue, valueOnDisplay, operation) ?? 0
            } catch ErrorMathOperation.divideByZero {
                displayLabel.text = ErrorMathOperation.divideByZero.description
            } catch  {
                displayLabel.text = ErrorMathOperation.errorMath.description
            }
        }
        previousValue = valueOnDisplay
        isOperationInProgress = false
        operation = nil
    }
    
    @IBAction func onButtonOperationTapped(_ sender: UIButton) {
        
        if  !isOperationInProgress {
            onButtonEqualTapped(sender)
        }
        operation = Operation(rawValue: sender.tag)
        isOperationInProgress = true
    }
    
    @IBAction func onUnaryButtonTapped(_ sender: UIButton) {
        guard let operation = Operation(rawValue: sender.tag) else {
            return
        }
        do {
        valueOnDisplay =  try mathOperation(valueOnDisplay, previousValue, operation) ?? 0
        } catch ErrorMathOperation.noValueSomeTg {
            displayLabel.text = ErrorMathOperation.noValueSomeTg.description
        } catch ErrorMathOperation.noValueSomeCtg {
            displayLabel.text = ErrorMathOperation.noValueSomeCtg.description
        } catch  {
            displayLabel.text = ErrorMathOperation.errorMath.description
        }
    }
}
    


