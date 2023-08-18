//
//  LocationManager.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/18.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI

class ReginLocation: ObservableObject {
    @Published var locationsRegin = MKCoordinateRegion()
    @Published var distance: CLLocationDistance = 0.0
    @Published var isEnter = false
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var reginLocation = ReginLocation()
    let geoCloudStoreModel = GeoCloudStoreModel()
    override init() {
        super.init()
        setupLocationManager()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            userLocation = location
            reginLocation.locationsRegin = MKCoordinateRegion(center: userLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0), latitudinalMeters: 0.05, longitudinalMeters: 0.05)
        }
        
        if let location = locations.last?.coordinate {
            userLocation = location
            print("userLocation:\(userLocation)")
            
            //            let coordinate1 = CLLocationCoordinate2D(latitude: 31.14550982027449, longitude: -121.31598035555947)
            //            let coordinate2 = CLLocationCoordinate2D(latitude: userLocation?.latitude ?? 0, longitude: userLocation?.longitude ?? 0)
            //
            //            let location1 = CLLocation(latitude: coordinate1.latitude, longitude: coordinate1.longitude)
            //            let location2 = CLLocation(latitude: coordinate2.latitude, longitude: coordinate2.longitude)
            //
            //            reginLocation.distance = location1.distance(from: location2)
            //            print("Distance: \(reginLocation.distance) meters")
            
            let distance = CLLocation(latitude: userLocation?.latitude ?? 0, longitude: userLocation?.longitude ?? 0).distance(from: CLLocation(latitude: 31.145530673235918, longitude: 121.31602902405824))
            
            reginLocation.distance = distance
            print("reginLocation:\(reginLocation.distance)")
            print("distance\(distance)")
            if  distance < 100 {
                print("I am enter the dangerous")
                reginLocation.isEnter = true
                geoCloudStoreModel.sendTheInformation(locationManager: self)
            }else{
                print("I am leave the dangerous")
                reginLocation.isEnter = false
            }
        }
    }
    
}
