//
//  OrderTableViewController.swift
//  pizzahub
//
//  Created by Yusuf Tezel on 04/08/2017.
//  Copyright © 2017 YTE. All rights reserved.
//

import UIKit

class OrderTableViewController: UITableViewController {
    
    let model = generateData()
    let basket: [Topping] = []
    let pizzaName = "Normal pizza"
    
    
    var pizzaCounter: UIStepper!
    var foodLabel: UILabel!
    var orderTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension OrderTableViewController {
    
    func updatePizzaLabelText(){
        foodLabel.text = "\(Int(pizzaCounter.value)) x \(pizzaName)"
    }
    
    func stepperValueChanged(_ sender: UIStepper) {
        updatePizzaLabelText()
    }
    
}

extension OrderTableViewController {
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if orderTableView != nil && tableView == orderTableView {return 1}
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if orderTableView != nil &&  tableView == orderTableView {
            return 9
        }
        if section == 0 {
            return 2
        }
        return model.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if orderTableView != nil && tableView == orderTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath)
            return cell
        }
        if indexPath == [0,0] {
            let cell = tableView.dequeueReusableCell(withIdentifier: "stepperCell", for: indexPath)
            pizzaCounter = cell.viewWithTag(1) as! UIStepper
            foodLabel = cell.viewWithTag(2) as! UILabel
            pizzaCounter.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
            updatePizzaLabelText()
            return cell
        }
        if indexPath == [0,1] {
            let cell = tableView.dequeueReusableCell(withIdentifier: "orderTableViewCell", for: indexPath)
            orderTableView = cell.viewWithTag(1) as! UITableView
            orderTableView.dataSource = self
            orderTableView.delegate = self
            orderTableView.reloadData()
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectionCell", for: indexPath)
        return cell
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.tableView && indexPath == [0,1] {
            return 200.0
        }
        return 44
    }
    
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
     }
 
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
