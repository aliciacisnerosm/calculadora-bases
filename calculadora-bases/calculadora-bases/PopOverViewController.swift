//
//  PopOverViewController.swift
//  calculadora-bases
//
//  Created by Alicia Cisneros  on 4/8/19.
//  Copyright © 2019 Alicia Cisneros. All rights reserved.
//

import UIKit

class PopOverViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = CGSize(width: 414, height: 500)

        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
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
