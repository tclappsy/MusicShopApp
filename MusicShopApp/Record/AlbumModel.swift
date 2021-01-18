//
//  AlbumModel.swift
//  MusicShopApp
//
//  Created by Tom Clappsy on 12/4/20.
//

import Foundation

struct AlbumData: Codable {
    var name: String
    var band: String
    var release: String
    var length: String
    var genre: String
    var price: Double
    
    enum CodingKeys: String, CodingKey {
        case name = "NAME"
        case band = "BAND"
        case release = "RELEASE"
        case length = "LENGTH"
        case genre = "GENRE"
        case price = "PRICE"
        
    }
}

class AlbumModel {
    var albums:[AlbumData] = []
    
    static let sharedInstance = AlbumModel()
    
    private init() {
        readAlbumData()
        print(albums.count)
    }
    
    func getAlbumData() -> [AlbumData] {
        return albums
    }
    
    func readAlbumData() {
        if let filename = Bundle.main.path(forResource:"albumData", ofType: "json") {
            do {
                let jsonStr = try String(contentsOfFile: filename)
                let jsonData = jsonStr.data(using: .utf8)!
                albums = try! JSONDecoder().decode([AlbumData].self, from: jsonData)
            } catch {
                print("This file cannot be loaded")
            }
        }
    }
}
