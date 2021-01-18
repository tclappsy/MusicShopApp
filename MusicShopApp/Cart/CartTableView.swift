//
//  CartTableView.swift
//  MusicShopApp
//
//  Created by Tom Clappsy on 12/7/20.
//

import Foundation
import UIKit

class CartTableView: UITableViewController {
    
    
    let cartModel = CartModel.sharedInstance
    let inst = InstrumentTableViewController()
    
    var items:[InstData] = []
    
    var totalPrice = 0.0
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        self.tableView.rowHeight = 100
        
        items = cartModel.items
        
        for price in items {
            totalPrice += price.price
        }
      
        self.title = "Total: $\(totalPrice)"
        refreshItems()
    }
  
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartCell
        //instruments
        
        let thisInst = items[indexPath.row]
        

        if(inst.instImages[thisInst.model] != nil) {
            cell.itemImage.image = UIImage(named: inst.instImages[thisInst.model]!)
        }

        cell.itemName.text = thisInst.name
        cell.itemPrice.text = "$" + String(thisInst.price)
        
        return cell
    }

    func refreshItems() {
        items.removeAll()
        items = cartModel.items
        items.sort{$0.price < $1.price}

        self.tableView.reloadData()
    }
    
    @IBAction func checkOut(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Checking out items...", message:"Total Price: $\(totalPrice)", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    
        items.removeAll()
        cartModel.removeAllItems()
        totalPrice = 0.0
        
        self.title = "Total: $\(totalPrice)"
        self.tableView.reloadData()
        
        print(items.count)
    }
    
  
    
    //deleting item
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {

            totalPrice -= items[indexPath.row].price
            cartModel.removeItem(itemIndex: indexPath.row)
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
             
            self.title = "Total: $\(totalPrice)"

        }
    }
}




