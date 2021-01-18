//
//  AlbumInfoViewController.swift
//  MusicShopApp
//
//  Created by Tom Clappsy on 12/4/20.
//

import Foundation
import UIKit

class AlbumInfoViewController: UIViewController {
    
    let cartModel = CartModel.sharedInstance


    var thisAlbum: AlbumData?
    let albumModel = AlbumModel.sharedInstance
    
    var image: UIImage?
    
    
    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var length: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(thisAlbum!)
        self.title = (thisAlbum?.name)!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let image = image {
            albumCover.image = image
        }
        
        releaseDate.text = String((thisAlbum?.release)!)
        genre.text = String((thisAlbum?.genre)!)
        length.text = String((thisAlbum?.length)!)
        price.text = "$" + String((thisAlbum?.price)!)
    }
    

    
    
}
