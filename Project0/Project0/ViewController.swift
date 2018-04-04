
import UIKit



final class ViewController: UIViewController {
    
    enum Operation: Int {
        case Divide = 15
        case Multiple = 14
        case Subtract = 13
        case Add = 12
    }
    
    var numberOnDisplay: Double = 0
    var previosNumber: Double = 0
    var tmpNumber: Double = 0
    var perfomingmath = false
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
    }
    
    @IBAction func onButtonDigitsTapped(_ sender: UIButton) {
        
        if perfomingmath == true{
            displayLabel.text = String(sender.tag)
            numberOnDisplay = Double(displayLabel.text!)!
            perfomingmath = false
        } else {
            guard let displayText = displayLabel.text, let displayInt =  Int(displayText) else { return }
            let result = displayInt * 10 + sender.tag
            numberOnDisplay = Double(result)
            tmpNumber = Double(result)
            displayLabel.text = String(result)
        }
    }
    
    
    @IBAction func onButtonOperationTapped(_ sender: UIButton) {
        
        guard let displayText = displayLabel.text, let displayInt =  Int(displayText) else { return }
       
        
        if displayLabel.text != "" && sender.tag != 11 {
            previosNumber = Double(displayInt)
            switch sender.tag {
            case Operation.Add.rawValue: displayLabel.text = String(previosNumber) + " + "
            case Operation.Subtract.rawValue: displayLabel.text = String(previosNumber) + " - "
            case Operation.Multiple.rawValue: displayLabel.text = String(previosNumber) + " * "
            case Operation.Divide.rawValue: displayLabel.text = String(previosNumber) + " / "
            case Operation.Divide.rawValue: displayLabel.text = String(previosNumber) + " % "
            default: return
            }
            operation = sender.tag
            perfomingmath = true
        } else if sender.tag == 11 {
            
            print(previosNumber)
            print(numberOnDisplay)
            
            switch operation {
            case 12:
                displayLabel.text = String(previosNumber + numberOnDisplay)
                tmpNumber = tmpNumber + numberOnDisplay
            case 13: displayLabel.text = String(previosNumber - numberOnDisplay)
            case 14: displayLabel.text = String(previosNumber * numberOnDisplay)
            case 15: displayLabel.text = String(previosNumber / numberOnDisplay)
            case 16: displayLabel.text = String(previosNumber / numberOnDisplay)
            default: return
            }
        }
    }
}

