//
//  InstrumentModel.swift
//  MusicShopApp
//
//  Created by Tom Clappsy on 11/21/20.
//

import Foundation

struct InstData:Codable {
    var model : String
    var name : String
    var price : Double
    var color : String
    var fretBoard : String
    var desc : String
    
    enum CodingKeys:String, CodingKey {
        case model = "Model"
        case name = "Name"
        case price = "Price"
        case color = "Color"
        case fretBoard = "Fretboard"
        case desc = "Desc"
    }
}
    
    class InstrumentModel {
        var inst:[InstData] = []
        
        static let sharedInstance = InstrumentModel()
        
        private init() {
            readInstData()
            print(inst.count)
        }
        
        func getInstData() -> [InstData] {
            return inst
        }
        
      
        func readInstData() {
            if let filename = Bundle.main.path(forResource:"instruments", ofType: "json") {
                do {
                    let jsonStr = try String(contentsOfFile: filename)
                    let jsonData = jsonStr.data(using: .utf8)!
                    inst = try! JSONDecoder().decode([InstData].self, from: jsonData)
                } catch {
                    print("This file cannot be loaded")
                }
            }
        }
    }

