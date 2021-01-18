//
//  CartItemCell.swift
//  MusicShopApp
//
//  Created by Tom Clappsy on 12/6/20.
//

import Foundation
import UIKit

class CartItemCell: UITableViewCell {
    
    @IBOutlet weak var itemPic: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected:Bool, animated: Bool) {
        super.setSelected(selected,animated: animated)
    }
    
}
