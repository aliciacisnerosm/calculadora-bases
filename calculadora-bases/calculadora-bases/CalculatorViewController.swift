
import UIKit

class CalculatorViewController: UIViewController {
	@IBOutlet weak var lbResult: UILabel!
	@IBOutlet weak var lbEquation: UILabel!
	@IBOutlet var btnNumpad: [UIButton]!
	@IBOutlet weak var btnDelete: UIButton!
	@IBOutlet var btnFunctions: [UIButton]!
	
	@IBOutlet weak var numButtonsStackView: UIStackView!
	@IBOutlet weak var changeBaseView: UIView!
	@IBOutlet var changeBaseViewConstraint: NSLayoutConstraint!
	
	var currentBase = 10
	var calculator : Calculator!
	
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
	
	// Default number in calculator on start up.
	var result = Number(base: 10, integralPart: "0", fractionalPart: nil)
	var activeOperation = 0
	var secondMode = false
	var hasTyped = false
	var showChangeBaseWindow = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		result = Number(base: currentBase, integralPart: "0", fractionalPart: nil)
		lbResult.text = "0"
		lbEquation.text = ""
		btnFunctions[2].titleLabel?.textAlignment = NSTextAlignment.center		// Special case to center a multi-lined button
		
		calculator = Calculator(history: HistoryManager(arrayHM: NSMutableArray()))
		
		self.changeBaseView.topAnchor.constraint(equalTo: numButtonsStackView.bottomAnchor)
		self.view.layoutIfNeeded()
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
			typeDigit(digit: sender.titleLabel!.text!)
			sender.backgroundColor = buttonColors[0]
			
		case 11:		// Delete/AC button
			if secondMode {
				allClear()
			} else {
				deleteDigit()
			}
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
			toggle2ndMode()
			
		case 16:		// Change polarity button
			sender.backgroundColor = buttonColors[3]
			
		case 17:		// Change base button
			toggleChangeBaseView()
			sender.backgroundColor = buttonColors[3]
			
		case 18:		// Settings button
			sender.backgroundColor = buttonColors[3]
			
		default:
			print("ERROR: Invalid button?")
		}
	}
	
	// Inputs a digit
	func typeDigit(digit: String) {
		if (lbResult.text == "0" || !hasTyped) {
			lbResult.text = digit
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
	
	// All clear function
	func allClear() {
		result = Number(base: currentBase, integralPart: "0", fractionalPart: nil)
		activeOperation = 0
		hasTyped = false
		
		lbResult.text = "0"
		lbEquation.text = ""
	}
	
	// Perform equal operation
	func operation(nextOp: Int) {
		let current = Number(base: currentBase, integralPart: lbResult.text!, fractionalPart: nil)
		
		// Adding to history of calculator.
		var equationToStore : String = ""
		
		switch activeOperation {
		case 0:		// Equal / No operation currently
			result = current
			lbEquation.text = current.getIntegralPart()
			
		case 1:		// Addition
			result = calculator.addNumbers(one: result, two: current, base: currentBase)
			lbEquation.text!.append(contentsOf: String(format: " + %@", current.getIntegralPart()))
		case 2:		// Subtraction
			result = calculator.subtractNumbers(one: result, two: current, base: currentBase)
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
	
	// Toggles keys based on the current base.
	func toggleKeysForBase(base: Int) {
		if secondMode {
			if base > 10 {
				toggleButton(button: btnNumpad[7], enabled: false)
				toggleButton(button: btnNumpad[8], enabled: false)
				toggleButton(button: btnNumpad[9], enabled: false)
				for idx in 1...6 {
					if idx + 10 <= base {
						toggleButton(button: btnNumpad[idx], enabled: true)
					} else {
						toggleButton(button: btnNumpad[idx], enabled: false)
					}
				}
			}
		} else {
			for idx in 0...9 {
				if idx < base {
					toggleButton(button: btnNumpad[idx], enabled: true)
				} else {
					toggleButton(button: btnNumpad[idx], enabled: false)
				}
			}
		}
	}
	
	// Helper function for 'toggle2ndMode'
	func lettersKeyPadForSecondMode() {
		
		if currentBase > 10 {
			btnNumpad[0].setTitle("00", for: .normal)
			btnNumpad[1].setTitle("A", for: .normal)
			btnNumpad[2].setTitle("B", for: .normal)
			btnNumpad[3].setTitle("C", for: .normal)
			btnNumpad[4].setTitle("D", for: .normal)
			btnNumpad[5].setTitle("E", for: .normal)
			btnNumpad[6].setTitle("F", for: .normal)
		}
		
		btnDelete.setTitle("AC", for: .normal)
		
		btnFunctions[1].setTitle("C", for: .normal)
		btnFunctions[2].setTitle("CD", for: .normal)
	}
	
	// Helper function for 'toggle2ndMode'
	func numberKeyPadForSecondMode() {
		btnNumpad[0].setTitle("0", for: .normal)
		btnNumpad[1].setTitle("1", for: .normal)
		btnNumpad[2].setTitle("2", for: .normal)
		btnNumpad[3].setTitle("3", for: .normal)
		btnNumpad[4].setTitle("4", for: .normal)
		btnNumpad[5].setTitle("5", for: .normal)
		btnNumpad[6].setTitle("6", for: .normal)
		
		btnDelete.setTitle("⌫", for: .normal)
		
		btnFunctions[0].backgroundColor = buttonColors[3]
		btnFunctions[1].setTitle("⁺∕₋", for: .normal)
		btnFunctions[2].setTitle("Change Base", for: .normal)
	}
	
	// Toggle '2nd' mode and change keys accordingly
	func toggle2ndMode() {
		secondMode = !secondMode
		
		if secondMode {		// 2nd mode
			lettersKeyPadForSecondMode()
			toggleKeysForBase(base: currentBase)
		} else {					// Normal mode
			numberKeyPadForSecondMode()
			toggleKeysForBase(base: currentBase)
		}
	}
	
	// Toggle view controller for changing window
	func toggleChangeBaseView() {
		showChangeBaseWindow = !showChangeBaseWindow
		
		changeBaseViewConstraint.isActive = false
		if showChangeBaseWindow {
			changeBaseViewConstraint = self.changeBaseView.topAnchor.constraint(equalTo: numButtonsStackView.topAnchor)
		} else {
			changeBaseViewConstraint = self.changeBaseView.topAnchor.constraint(equalTo: numButtonsStackView.bottomAnchor)
		}
		changeBaseViewConstraint.isActive = true
		
		UIView.animate(withDuration: 0.3) { self.view.layoutIfNeeded() }
	}
	
	// Toggle button usability and visibility
	func toggleButton(button: UIButton, enabled: Bool) {
		button.isEnabled = enabled
		button.backgroundColor = button.isEnabled ? buttonColors[0] : activeColors[0]
	}
	
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Get the new view controller using segue.destination.
		// Pass the selected object to the new view controller.
		
		if segue.identifier == "selectBase" {
			let basesController = segue.destination as! BasesViewController
			basesController.selectedBase = currentBase
		}
	}
	
	@IBAction func unwindBases(unwindSegue : UIStoryboardSegue) {
		allClear()
		toggleKeysForBase(base: currentBase)
	}
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
