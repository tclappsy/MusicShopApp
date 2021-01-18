//
//  MapAnnotation.swift
//  MusicShopApp
//
//  Created by Tom Clappsy on 11/25/20.
//

import Foundation
import MapKit
import Contacts

class MapAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subTitle : String?
    
    init(_ latitude: CLLocationDegrees, longitude: CLLocationDegrees, title: String, subTitle: String) {
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.title = title
        self.subTitle = subTitle
    }
    
    func mapItem() -> MKMapItem {
        let destTitle = title! + " , " + subTitle!
        let addressDict = [CNPostalAddressCityKey: destTitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark:placemark)
        return mapItem
    }
}
