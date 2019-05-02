//
//  HistoryTableViewController.swift
//  calculadora-bases
//
//  Created by Alicia Cisneros  on 4/8/19.
//  Copyright © 2019 Alicia Cisneros. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    @IBAction func disItem(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
        return false
    }
    
    var arrayHM : NSMutableArray = NSMutableArray()
    var operationData : [OperationData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let history = HistoryManager(arrayHM: arrayHM)
        arrayHM = history.loadData()
        operationData = history.retrieveParamsArray()
        
        self.view.backgroundColor = UIColor(red: 50/256, green: 50/256, blue: 50/256, alpha: 1.0)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayHM.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "idcell", for: indexPath) as! HistoryMTableViewCell
        cell.operation?.text = (arrayHM[indexPath.row] as! String)
        cell.lbOrder?.text = String(indexPath.row + 1)
        let params = operationData
        let opdata = params![indexPath.row]
        cell.lbBase?.text = "base " + String(opdata.params[1])
        cell.backgroundColor = cellColorForIndex(indexPath: indexPath)
        return cell
    }
    
    func cellColorForIndex(indexPath:IndexPath) -> UIColor{
        let row = CGFloat(indexPath.row)
       // let section = CGFloat(indexPath.section)
        let saturation  = 1.0 - row / CGFloat(arrayHM.count)
        return UIColor(hue: CGFloat(0.80), saturation: saturation, brightness: 0.8, alpha: 1.0)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let historyDetail = segue.destination as! HistoryDetailViewController
        
        if let row = self.tableView.indexPathForSelectedRow?.row,
            let params = operationData {
            
            let opData = params[row]
            
            historyDetail.operation = opData.functionName
            
            if opData.functionName == "addition" || opData.functionName == "subtraction" || opData.functionName == "suma" || opData.functionName == "resta" {
                historyDetail.firstNum = opData.params[2]
                historyDetail.secondNum = opData.params[3]
                historyDetail.base = opData.params[1]
                historyDetail.answer = opData.params[4]
            } else {
                historyDetail.firstNum = opData.params[2]
                historyDetail.answer = opData.params[3]
                historyDetail.base = opData.params[1]
            }
            
            var sign : String
            
            switch opData.functionName {
            case "addition", "suma":
                sign = "+"
            case "subtraction", "resta":
                sign = "-"
            case "diminished radix complement", "complemento disminuido":
                sign = "CD"
            default:
                sign = "C"
            }
            
            historyDetail.operatorSign = sign
        }
    }
 

}
