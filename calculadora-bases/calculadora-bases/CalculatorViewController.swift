
import UIKit

class CalculatorViewController: UIViewController {
	@IBOutlet weak var lbResult: UILabel!
	@IBOutlet weak var lbEquation: UILabel!
	
	let calculator = Calculator()
	var result = Number(base: 10, integralPart: "0", fractionalPart: nil)
	var activeOperation = 0
	var hasTyped = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		lbResult.text = "0"
		lbEquation.text = ""
	}
	
	// MARK: - Calculator buttons
	// Activates when a button is held down
	@IBAction func buttonHold(_ sender: UIButton) {
		// Alter background color and border
		sender.layer.borderColor = UIColor(rgb: 0x191919).cgColor
		sender.layer.borderWidth = 3
	}
	
	// Activates when a button is pressed
	@IBAction func buttonPress(_ sender: UIButton) {
		sender.layer.borderWidth = 0			// Reset border
		
		switch sender.tag {
			// Numpad button (0-9, A-F, .)
			// Note: Case 10 (.) is omitted because decimals have not been implemented yet
		case 0,
				 1,
				 2,
				 3,
				 4,
				 5,
				 6,
				 7,
				 8,
				 9:
			typeDigit(digit: Character(String(sender.tag)))
			
			// Delete button
		case 11:
			deleteDigit()
			
			// Equal button
		case 12:
			if activeOperation != 0 || hasTyped {
				operation(nextOp: 0)
			}
			
			// Add button
		case 13:
			if activeOperation != 1 || hasTyped {
				operation(nextOp: 1)
			}
			
			// Subtract button
		case 14:
			if activeOperation != 2 || hasTyped {
				operation(nextOp: 2)
			}
			
		default:
			print("ERROR: Invalid button?")
		}
	}
	
	// Inputs a digit
	func typeDigit(digit: Character) {
		if (lbResult.text == "0" || !hasTyped) {
			lbResult.text = String(digit)
		} else {
			lbResult.text!.append(digit)
		}
		
		hasTyped = true
	}
	
	// Deletes a digit
	func deleteDigit() {
		if (lbResult.text!.count > 1) {
			lbResult.text!.removeLast()
			hasTyped = true
		} else if lbResult.text != "0" {
			lbResult.text = "0"
			hasTyped = true
		}
	}
	
	// Perform equal operation
	func operation(nextOp: Int) {
		let current = Number(base: 10, integralPart: lbResult.text!, fractionalPart: nil)
		
		switch activeOperation {
		case 0:		// Equal / No operation currently
			result = current
			lbEquation.text = current.getIntegralPart()
		case 1:		// Addition
			result = calculator.addNumbers(one: result, two: current, base: 10)
			lbEquation.text!.append(contentsOf: String(format: " + %@", current.getIntegralPart()))
		case 2:		// Subtraction
			result = calculator.subtractNumbers(one: result, two: current, base: 10)
			lbEquation.text!.append(contentsOf: String(format: " - %@", current.getIntegralPart()))
		default:
			print("ERROR: Invalid operation?")
		}
		
		lbResult.text = result.getIntegralPart()
		hasTyped = false
		activeOperation = nextOp
		
		if activeOperation == 0 {
			lbEquation.text?.append(contentsOf: " =")
		}
	}
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destination.
	// Pass the selected object to the new view controller.
	}
	*/
}

// MARK: - Extensions
// UIColor extension to accept hex strings for colors
extension UIColor {
	convenience init(red: Int, green: Int, blue: Int) {
		assert(red >= 0 && red <= 255, "Invalid red component")
		assert(green >= 0 && green <= 255, "Invalid green component")
		assert(blue >= 0 && blue <= 255, "Invalid blue component")
		
		self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
	}
	
	convenience init(rgb: Int) {
		self.init(
			red: (rgb >> 16) & 0xFF,
			green: (rgb >> 8) & 0xFF,
			blue: rgb & 0xFF
		)
	}
}
