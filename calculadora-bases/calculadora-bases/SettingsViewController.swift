//
//  SettingsViewController.swift
//  calculadora-bases
//
//  Created by Daniel Hernandez on 5/1/19.
//  Copyright © 2019 Alicia Cisneros. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPopoverPresentationControllerDelegate {
	
	@IBAction func disItem(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
    @IBAction func btnInfo(_ sender: Any) {
        
    }
    override func viewDidLoad() {
		super.viewDidLoad()
	}
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
        return false
    }
   
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
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
