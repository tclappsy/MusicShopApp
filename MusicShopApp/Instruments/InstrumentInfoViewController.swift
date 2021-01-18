//
//  InstrumentInfoViewController.swift
//  MusicShopApp
//
//  Created by Tom Clappsy on 11/21/20.
//

import Foundation
import UIKit



class InstrumentInfoViewController: UIViewController {

    var thisInst: InstData?
    
    let cartModel = CartModel.sharedInstance
        
    var image : UIImage?
    
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var fretboard: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(thisInst!)
        self.title = (thisInst?.name)!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let image = image {
            pic.image = image
        }
        
        desc.text = String((thisInst?.desc)!)
        price.text = "$" + String((thisInst?.price)!)
        fretboard.text = String((thisInst?.fretBoard)!)
        color.text = String((thisInst?.color)!)
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
        
        let alert = UIAlertController(title:"Item Added!", message:"Added: \(thisInst!.name)", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title:"OK", style:.default)
        
        alert.addAction(okAction)
        present(alert,animated: true, completion: nil)
        

        cartModel.addInstsToCart(newItem: thisInst!)
        print(cartModel.returnCartItems())
    }
    
    
    
    @IBAction func cart(_ sender: Any) {
        
        performSegue(withIdentifier: "cart", sender: self)
        
    }
   
    
    
  
    
    
}
