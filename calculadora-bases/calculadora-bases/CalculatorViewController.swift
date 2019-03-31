
import UIKit

class CalculatorViewController: UIViewController {
	@IBOutlet weak var lbResult: UILabel!
	@IBOutlet weak var lbEquation: UILabel!
	
	let calculator = Calculator()
	let buttonColors = [
		UIColor(hex: 0xffffff),
		UIColor(hex: 0xfc3951),
		UIColor(hex: 0xdd86fc),
		UIColor(hex: 0x555555)
	]
	let activeColors = [
		UIColor(hex: 0xe4e4e4),
		UIColor(hex: 0xce2f42),
		UIColor(hex: 0xca7be6),
		UIColor(hex: 0x3d3d3d)
	]
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
		sender.layer.borderColor = UIColor(hex: 0x191919).cgColor
		sender.layer.borderWidth = 3
		
		if sender.tag <= 10 {		// 0..9 & . buttons
			sender.backgroundColor = activeColors[0]
		} else if sender.tag == 11 {		// Delete button
			sender.backgroundColor = activeColors[1]
		} else if sender.tag <= 14 {		// =, +, & - buttons
			sender.backgroundColor = activeColors[2]
		} else if sender.tag <= 18 {		// Functions buttons
			sender.backgroundColor = activeColors[3]
		}
	}
	
	// Activates when a button is pressed
	@IBAction func buttonPress(_ sender: UIButton) {
		sender.layer.borderWidth = 0			// Reset border
		
		switch sender.tag {
		case 0,
				 1,
				 2,
				 3,
				 4,
				 5,
				 6,
				 7,
				 8,
				 9:			// Numpad button (0-9, A-F, .) Note: Case 10 (.) is omitted because decimals have not been implemented yet
			typeDigit(digit: Character(String(sender.tag)))
			sender.backgroundColor = buttonColors[0]
			
		case 11:		// Delete button
			deleteDigit()
			sender.backgroundColor = buttonColors[1]
			
		case 12:		// Equal button
			if activeOperation != 0 || hasTyped {
				operation(nextOp: 0)
			}
			sender.backgroundColor = buttonColors[2]
			
		case 13:		// Add button
			if activeOperation != 1 || hasTyped {
				operation(nextOp: 1)
			}
			sender.backgroundColor = buttonColors[2]
			
		case 14:		// Subtract button
			if activeOperation != 2 || hasTyped {
				operation(nextOp: 2)
			}
			sender.backgroundColor = buttonColors[2]
			
		case 15:		// '2nd' button
			sender.backgroundColor = buttonColors[3]
			
		case 16:		// Change polarity button
			sender.backgroundColor = buttonColors[3]
			
		case 17:		// Change base button
			sender.backgroundColor = buttonColors[3]
			
		case 18:		// Settings button
			sender.backgroundColor = buttonColors[3]
			
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
	
	convenience init(hex: Int) {
		self.init(
			red: (hex >> 16) & 0xFF,
			green: (hex >> 8) & 0xFF,
			blue: hex & 0xFF
		)
	}
}
