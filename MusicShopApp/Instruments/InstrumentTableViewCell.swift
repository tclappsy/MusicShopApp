//
//  InstrumentTableViewCell.swift
//  MusicShopApp
//
//  Created by Tom Clappsy on 11/21/20.
//

import Foundation
import UIKit

class InstrumentTableViewCell: UITableViewCell{
    
   
    @IBOutlet weak var instImage: UIImageView!
    @IBOutlet weak var instName: UILabel!
    @IBOutlet weak var price: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected:Bool, animated: Bool) {
        super.setSelected(selected,animated: animated)
    }
    

    
 
    
    
}
