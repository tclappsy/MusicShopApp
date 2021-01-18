//
//  CartCell.swift
//  MusicShopApp
//
//  Created by Tom Clappsy on 12/9/20.
//

import Foundation
import UIKit

class CartCell: UITableViewCell {
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected:Bool, animated: Bool) {
        super.setSelected(selected,animated: animated)
    }
    
    
    
}
