//
//  InstrumentTableViewController.swift
//  MusicShopApp
//
//  Created by Tom Clappsy on 11/20/20.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class InstrumentTableViewController: UITableViewController, UISearchResultsUpdating {
  
    
    var instSearchController = UISearchController()
    
    let instModel = InstrumentModel.sharedInstance
    
    var insts:[InstData] = []
    var currentInst: [InstData]!
    
    var selectedInstr: InstData?
    
    //filtered array
    var filteredData:[InstData] = []
    
    //cart information
    //var info = InstrumentInfoViewController()
    //var cartItems: [String] = []
    
    let instImages = ["#0144502515":"whiteStrat.jpg","#0144502506":"blackStrat.jpg","#0144502513": "blueStrat.jpg","#0145212500":"3colorTele.jpg","#0145212506": "blacktele.jpg", "#0145212550":"tanTele.jpg", "#0113940761":"darknighttele.jpg", "#0113940755": "mercuryTele.jpg","#0118050712":"ultraBlastJazz.jpg", "#0113970755":"greyjazz.jpg", "#0115210302":"blueJazz.jpg", "#999":"gibson345.jpg","#1010":"lespaul.jpg","#888":"jimmy.jpg","#99":"martin1.jpg","#88":"martin2.jpg","#77":"taylor.jpg","#1200":"taylorT5.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Instruments In Stock"
        
        currentInst = insts

    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        self.tableView.rowHeight = 100
        
        refreshInsts()
        
        instSearchController = ({
            let search = UISearchController(searchResultsController: nil)
            search.searchResultsUpdater = self
            search.obscuresBackgroundDuringPresentation = false
            search.searchBar.placeholder = "Search by name, color, or price"
            self.tableView.tableHeaderView = search.searchBar
            return search
        })()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        print(text)
        
        if text.count > 0 {
            filteredData.removeAll()
            filteredData = insts.filter ({
                ($0.name.lowercased().contains(text.lowercased())) ||
                ($0.color.lowercased().contains(text.lowercased())) ||
                (String($0.price).lowercased().contains(text.lowercased()))
            })
        } else {
            filteredData = insts
        }
        
        print(filteredData.count)
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(instSearchController.isActive) {
            print("filtered instrument count: \(filteredData.count)")
            return filteredData.count
        } else {
            print("instrument count: \(insts.count)")
            return insts.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "instCell", for: indexPath) as! InstrumentTableViewCell
        

        //print(indexPath.row)
        
        //let thisInst = insts[indexPath.row]
        var thisInst : InstData!
        
        if(instSearchController.isActive) {
            thisInst = filteredData[indexPath.row]
        } else {
            thisInst = insts[indexPath.row]
        }
        
        //print(thisInst.name)
        
        if(instImages[thisInst.model] != nil) {
            cell.instImage.image = UIImage(named: instImages[thisInst.model]!)
        }
        
        cell.instName.text = thisInst.name
        cell.price.text = "$" + String(thisInst.price)
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedInstr = insts[indexPath.row]
        performSegue(withIdentifier: "description", sender: self)

  
    }
    
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "description" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let dvc = segue.destination as! InstrumentInfoViewController
                dvc.thisInst = selectedInstr
                
                
                let thisInst = insts[indexPath.row]
                dvc.image = UIImage(named: instImages[thisInst.model]!)

            }
        }
    }
    


    
    func refreshInsts() {
        insts.removeAll()
        insts = instModel.inst
        insts.sort{$0.price < $1.price}
        
        self.tableView.reloadData()
    }
    
    func findLogo(inName name: String, logos logosDictionary:[String:String]) -> String {
        var match = "other"
        let logos = Array(logosDictionary.keys)
        for logo in logos {
            if name.lowercased().contains(logo.lowercased()) {
                match = logo
                break
            }
        }
        return match
    }
    
    
    @IBAction func logoutButton(_ sender: UIBarButtonItem) {
        let user = Auth.auth().currentUser!
        let onlineRef = Database.database().reference(withPath: "online/\(user.uid)")
        onlineRef.removeValue { (error, _) in
            if let error = error {
                print("Removing user online failed: \(error)")
                return
            }
            do {
                try Auth.auth().signOut()
                self.dismiss(animated: true, completion: nil)
            } catch (let error) {
                print("Auth sign out failed: \(error)")
            }
        }
    }
    
    
    @IBAction func cartItems(_ sender: Any) {
        
        performSegue(withIdentifier: "cart", sender: self)
        
    }
    

}
