//
//  LocationsViewController.swift
//  MusicShopApp
//
//  Created by Tom Clappsy on 11/25/20.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class LocationsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var shopMap: MKMapView!
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    let mapDataModel = MapModel.sharedInstance
    var map: [MapData] = []
    var mapAnnotation: [MapAnnotation] = []
    
    let region = 8000.00
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        shopMap.showsUserLocation = true
        shopMap.delegate = self
        map = mapDataModel.shops
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        centerMapToLocation()
        addBallparks()
    }
    
    //change this
    func centerMapToLocation() {
        let startingLocation = CLLocation(latitude: 40.309260, longitude: -73.988190)
        let startingLocation2D = CLLocationCoordinate2D(latitude: startingLocation.coordinate.latitude, longitude: startingLocation.coordinate.longitude)
        let coordRegion = MKCoordinateRegion(center: startingLocation2D, latitudinalMeters: region, longitudinalMeters: region)
        shopMap.setRegion(coordRegion, animated:true)
    }
    
    func addBallparks() {
        for locations in map {
            let annotation = MapAnnotation(locations.lat, longitude: locations.long, title: locations.name, subTitle: locations.city)
            mapAnnotation.append(annotation)
        }
        shopMap.addAnnotations(mapAnnotation)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        currentLocation = userLocation.location
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = MKMarkerAnnotationView()
        
        let identifier = "ballpark"
        
        guard annotation is MapAnnotation else {return nil}
        
        annotationView.clusteringIdentifier = nil
        if let dequedAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as?
            MKMarkerAnnotationView {
            annotationView = dequedAnnotation
        } else {
            annotationView.markerTintColor = UIColor.black //black pin
            annotationView.animatesWhenAdded = true
            annotationView.glyphImage = UIImage(named: "icons8-baseball_field_.png")
            
            annotationView.canShowCallout = true
            annotationView.calloutOffset = CGPoint(x: -5.0, y:5.0)
            
            let mapViewButton = UIButton (frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 50.0, height: 60.0)))
            mapViewButton.setBackgroundImage(UIImage(named: "icons8-apple_map.png"), for: UIControl.State())
            annotationView.rightCalloutAccessoryView = mapViewButton
        }
        
        return annotationView
    }
    
    func mapView(_ mapMapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! MapAnnotation
        if view.rightCalloutAccessoryView == control {
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            //open apple maps
            location.mapItem().openInMaps(launchOptions: launchOptions)
        }
    }
    
    @IBAction func mapSelector(_ sender: UISegmentedControl) {
        switch(sender.selectedSegmentIndex) {
        case 0 :
            shopMap.mapType = .standard
        case 1:
            shopMap.mapType = .satellite
        case 2:
            shopMap.mapType = .hybrid
        default:
            shopMap.mapType = .standard
        }
    }
}
    

