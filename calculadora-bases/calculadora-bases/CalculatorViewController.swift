
import UIKit

class CalculatorViewController: UIViewController, changeBaseProtocol {
	@IBOutlet weak var lbResult: UILabel!
	@IBOutlet weak var lbEquation: UILabel!
	@IBOutlet var btnNumpad: [UIButton]!
	@IBOutlet weak var btnDelete: UIButton!
	@IBOutlet var btnFunctions: [UIButton]!
	
	@IBOutlet weak var numButtonsStackView: UIStackView!
	@IBOutlet weak var changeBaseView: UIView!
	@IBOutlet var changeBaseViewConstraint: NSLayoutConstraint!
	
	private var basesVC: BasesViewController!
	
	var currentBase = 10
	var calculator: Calculator!
	
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
	func changeButtonLook(pressed: Bool, sender: UIButton) {
		let tag = sender.tag
		
		if pressed {		// Pressed-down look
			sender.layer.borderColor = UIColor(hex: 0x191919).cgColor
			sender.layer.borderWidth = 3
			
			if tag <= 10 {						// 0..9 & . buttons
				sender.backgroundColor = activeColors[0]
			} else if tag == 11 {		// Delete button
				sender.backgroundColor = activeColors[1]
			} else if tag <= 14 {		// =, +, & - buttons
				sender.backgroundColor = activeColors[2]
			} else if tag <= 18 {		// Functions buttons
				sender.backgroundColor = activeColors[3]
			}
		} else {				// Normal look
			sender.layer.borderWidth = 0
			
			if tag <= 10 {						// 0..9 & . buttons
				sender.backgroundColor = buttonColors[0]
			} else if tag == 11 {		// Delete button
				sender.backgroundColor = buttonColors[1]
			} else if tag <= 14 {		// =, +, & - buttons
				sender.backgroundColor = buttonColors[2]
			} else if tag <= 18 {		// Functions buttons
				sender.backgroundColor = buttonColors[3]
			}
		}
	}
	
	// Activates when a button is held down
	@IBAction func buttonHold(_ sender: UIButton) {
		// Toggle button look
		changeButtonLook(pressed: true, sender: sender)
	}
	
	// Activates when a button is pressed, but dragged outside before release
	@IBAction func buttonDragOut(_ sender: UIButton) {
		// Reset button look
		changeButtonLook(pressed: false, sender: sender)
	}
	
	// Activates when a button is pressed
	@IBAction func buttonPress(_ sender: UIButton) {
		// Reset button look
		changeButtonLook(pressed: false, sender: sender)
		
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
				 9,
				 10:		// Numpad button (0-9, A-F, .)
			typeDigit(digit: sender.titleLabel!.text!)
			
		case 11:		// Delete/AC button
			if secondMode {
				allClear()
			} else {
				deleteDigit()
			}
			
		case 12:		// Equal button
			if activeOperation != 0 || hasTyped {
				operation(nextOp: 0)
			}
			
		case 13:		// Add button
			if activeOperation != 1 || hasTyped {
				operation(nextOp: 1)
			}
			
		case 14:		// Subtract button
			if activeOperation != 2 || hasTyped {
				operation(nextOp: 2)
			}
			
		case 15:		// '2nd' button
			toggle2ndMode()
			
		case 16:		// Change polarity/Complement button
			if secondMode {
				operation(nextOp: 3)
			} else {
				changePolarity()
			}
			
		case 17:		// Change base/Diminished complement button
			if secondMode {
				operation(nextOp: 4)
			} else {
				toggleChangeBaseView()
			}
			
		case 18:		// History/Settings button
			if secondMode {
				performSegue(withIdentifier: "settings", sender: nil)
			} else {
				performSegue(withIdentifier: "history", sender: nil)
			}
			
		default:
			print("ERROR: Invalid button?")
		}
	}
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
        return false
    }
	
	// Inputs a digit
	func typeDigit(digit: String) {
		if (lbResult.text == "0" || lbResult.text == "-0" || !hasTyped) && digit != "." {
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
	
	func changePolarity() {
		if lbResult.text!.first == "-" {
			lbResult.text!.removeFirst()
		} else {
			lbResult.text = "-" + lbResult.text!
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
		let numString = lbResult.text?.components(separatedBy: ".")
		let number: Number
		if numString!.count > 1 {
			number = Number(base: currentBase, integralPart: numString!.first!, fractionalPart: numString!.last!)
		} else {
			number = Number(base: currentBase, integralPart: numString!.first!, fractionalPart: nil)
		}
		
		
		switch activeOperation {
		case 0:		// Equal / No operation currently
			result = number
			lbEquation.text = number.stringFormat()
			
		case 1:		// Addition
			result = calculator.addNumbers(one: result, two: number, base: currentBase)
			lbEquation.text!.append(contentsOf: String(format: " + %@", number.stringFormat()))
			
		case 2:		// Subtraction
			result = calculator.subtractNumbers(one: result, two: number, base: currentBase)
			lbEquation.text!.append(contentsOf: String(format: " - %@", number.stringFormat()))
			
		default:
			print("ERROR: Invalid operation?")
		}
		
		activeOperation = nextOp
		
		// Complements are done after all existing operations
		if activeOperation == 3 {						// Complement
			result = calculator.getRadixComplement(num: result)
			lbEquation.text!.append(" → C")
			activeOperation = 0
		} else if activeOperation == 4 {		// Diminished Complement
			result = calculator.getDiminishedRadixComplement(num: result)
			lbEquation.text!.append(" → CD")
			activeOperation = 0
		}
		
		lbResult.text = result.stringFormat()
		hasTyped = false
		
		if activeOperation == 0 {
			lbEquation.text!.append(contentsOf: " =")
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
	
	// Toggle '2nd' mode and change keys accordingly
	func toggle2ndMode() {
		secondMode = !secondMode
		
		if secondMode {		// 2nd mode
			// Numpad
			if currentBase > 10 {
				btnNumpad[0].setTitle("00", for: .normal)
				btnNumpad[1].setTitle("A", for: .normal)
				btnNumpad[2].setTitle("B", for: .normal)
				btnNumpad[3].setTitle("C", for: .normal)
				btnNumpad[4].setTitle("D", for: .normal)
				btnNumpad[5].setTitle("E", for: .normal)
				btnNumpad[6].setTitle("F", for: .normal)
			}
			
			// Delete key
			btnDelete.setTitle("AC", for: .normal)
			
			// Function keys
			btnFunctions[0].backgroundColor = activeColors[3]
			btnFunctions[1].setTitle("C", for: .normal)
			btnFunctions[2].setTitle("CD", for: .normal)
			btnFunctions[3].setTitle("Settings", for: .normal)
		} else {					// Normal mode
			// Numpad
			btnNumpad[0].setTitle("0", for: .normal)
			btnNumpad[1].setTitle("1", for: .normal)
			btnNumpad[2].setTitle("2", for: .normal)
			btnNumpad[3].setTitle("3", for: .normal)
			btnNumpad[4].setTitle("4", for: .normal)
			btnNumpad[5].setTitle("5", for: .normal)
			btnNumpad[6].setTitle("6", for: .normal)
			
			// Delete key
			btnDelete.setTitle("⌫", for: .normal)
			
			// Function keys
			btnFunctions[1].setTitle("⁺∕₋", for: .normal)
			btnFunctions[2].setTitle("Change Base", for: .normal)
			btnFunctions[3].setTitle("History", for: .normal)
		}
		toggleKeysForBase(base: currentBase)
	}
	
	// Toggle view controller for changing window
	func toggleChangeBaseView() {
		showChangeBaseWindow = !showChangeBaseWindow
		
		changeBaseViewConstraint.isActive = false
		if showChangeBaseWindow {
			basesVC.currentNum = result
			basesVC.reloadData()
			
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
	
	// MARK: - Protocols
	func convertNumber(base: Int) -> Number {
		return calculator.convertBase(one: result, base: base)
	}
	
	func changeBaseAndDismiss(num: Number) {
		allClear()
		toggleKeysForBase(base: num.base)
		result = num
		currentBase = num.base
		lbResult.text = num.stringFormat()
		toggleChangeBaseView()
	}
	
	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "selectBase" {
			let basesController = segue.destination as! BasesViewController
			basesVC = basesController
			basesController.currentNum = result
			basesController.delegate = self
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
