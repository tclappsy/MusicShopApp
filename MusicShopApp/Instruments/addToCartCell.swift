//
//  addToCartCell.swift
//  MusicShopApp
//
//  Created by Tom Clappsy on 12/3/20.
//

import Foundation
import UIKit

class addToCartCell: UITableViewCell {
    
    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected:Bool, animated: Bool) {
        super.setSelected(selected,animated: animated)
    }
    
    
}
