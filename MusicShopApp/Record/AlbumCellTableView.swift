//
//  AlbumCellTableView.swift
//  MusicShopApp
//
//  Created by Tom Clappsy on 12/4/20.
//

import Foundation
import UIKit

class AlbumCellTableView: UITableViewCell {
    
    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var bandName: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected:Bool, animated: Bool) {
        super.setSelected(selected,animated: animated)
    }
    
    
}
