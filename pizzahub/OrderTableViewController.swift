//
//  OrderTableViewController.swift
//  pizzahub
//
//  Created by Yusuf Tezel on 04/08/2017.
//  Copyright © 2017 YTE. All rights reserved.
//

import UIKit

class OrderTableViewModel {
    var numberOfType: Int
    let topping: Topping
    
    init(numberOfType: Int, topping: Topping){
        self.numberOfType = numberOfType
        self.topping = topping
    }
}

class OrderTableViewController: UITableViewController {
    
    let model = generateData()
    let pizzaName = "Normal pizza"
    
    var pizzaCounter: UIStepper!
    var foodLabel: UILabel!
    var orderTableView: UITableView!
    var toppingCollectionViews: [UICollectionView] = []
    
    var temp: [OrderTableViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension OrderTableViewController {
    
    func updatePizzaLabelText(){
        foodLabel.text = "\(Int(pizzaCounter.value)) x \(pizzaName)"
    }
    
    func stepperValueChanged(_ sender: UIStepper) {
        updatePizzaLabelText()
    }
    
    func toppingButtonPressed(_ sender: ToppingButton){
        toppingGroupedAfterType(topping: sender.topping)
        orderTableView.reloadData()
    }
    
    func toppingGroupedAfterType(topping: Topping){
        let index = temp.index(where: {$0.topping == topping})
        if index == nil {
            temp.append(OrderTableViewModel(numberOfType: 1, topping: topping))
        }
        else{
            temp[index!].numberOfType = temp[index!].numberOfType + 1
        }
    }
}

extension OrderTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let index = toppingCollectionViews.index(of: collectionView) else {return 0}
        return model[index].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = toppingCollectionViews.index(of: collectionView)!
        let topping = model[index][indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "toppingCollectionViewCell", for: indexPath)
        let toppingButton = cell.viewWithTag(1) as! ToppingButton
        toppingButton.topping = topping
        toppingButton.setImage( UIImage(named: topping.name) , for: .normal)
        toppingButton.addTarget(self, action: #selector(toppingButtonPressed), for: .touchUpInside)
        return cell
    }
}

extension OrderTableViewController {
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if orderTableView != nil && tableView == orderTableView {
            return 1
        }
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if orderTableView != nil &&  tableView == orderTableView {
            return temp.count
        }
        if section == 0 {
            return 2
        }
        return model.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if orderTableView != nil && tableView == orderTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath)
            let label = cell.viewWithTag(1) as! UILabel
            label.text = "\(temp[indexPath.row].numberOfType) x \(temp[indexPath.row].topping.name)"
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
        let collectionView = cell.viewWithTag(1) as! UICollectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        toppingCollectionViews.append(collectionView)
        return cell
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if orderTableView != nil && tableView == orderTableView {
            return 35
        }
        if tableView == self.tableView && indexPath == [0,1] {
            return 200.0
        }
        if indexPath.section == 1 {return 80}
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
