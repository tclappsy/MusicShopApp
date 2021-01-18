//
//  MapModel.swift
//  MusicShopApp
//
//  Created by Tom Clappsy on 11/25/20.
//

import Foundation

struct MapData: Codable {
    
    var name: String
    var lat: Double
    var long: Double
    var city: String
    var county: String

    enum CodingKeys: String, CodingKey {

        case name = "NAME"
        case lat = "LATITUDE"
        case long = "LONGITUDE"
        case city = "CITY"
        case county = "COUNTY"
    }
}

class MapModel {
    var shops:[MapData] = []
    
    
    static let sharedInstance = MapModel()
    
    private init() {
        readMapData()
        print(shops.count)
        
    }
    
    func getShopData() -> [MapData] {
        return shops
        
    }
    
    func readMapData() {
        if let filename = Bundle.main.path(forResource: "coords", ofType: "json") {
            do {
                let jsonStr = try String (contentsOfFile: filename)
                let jsonData = jsonStr.data(using: .utf8)!
                //error is here ! cannot read json
                shops = try! JSONDecoder().decode([MapData].self, from:jsonData)
            } catch {
                print("This file cannot be loaded")
            }
        }
    }
}
