//
//  CartModel.swift
//  MusicShopApp
//
//  Created by Tom Clappsy on 12/8/20.
//

import Foundation

class CartModel {
    
    var items: [InstData] = []
    
    static let sharedInstance = CartModel()

    func addInstsToCart(newItem item: InstData) {
    
        items.append(item)
        
        print("added inst to cart: ")
        print(items.count)
    }
    
    func removeItem(itemIndex: Int) {
        items.remove(at: itemIndex)
    }
    
    func removeAllItems() {
        items.removeAll()
    }
    
    func returnCartItems() -> [InstData] {
        return items
    }
    
}
