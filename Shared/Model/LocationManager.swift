//
//  LocationManager.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/31.
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
            
            let distance = CLLocation(latitude: userLocation?.latitude ?? 0, longitude: userLocation?.longitude ?? 0).distance(from: CLLocation(latitude: 31.145530673235918, longitude: 121.31602902405824))
            
            reginLocation.distance = distance
            print("reginLocation:\(reginLocation.distance)")
            print("distance\(distance)")
            
            if  distance < 100 {
                print("I am enter the dangerous")
                reginLocation.isEnter = true
                return
            }else{
//                print("I am leave the dangerous")
                reginLocation.isEnter = false
            }
            
//            for geoDistance in GeoData {
//                let newDistance = CLLocation(latitude: userLocation?.latitude ?? 0, longitude: userLocation?.longitude ?? 0).distance(from: CLLocation(latitude: geoDistance.latitude, longitude: geoDistance.longitude))
//
//                reginLocation.distance = newDistance
//                print("reginLocation:\(reginLocation.distance)")
//                print("distance\(newDistance)")
//
//                if  newDistance < 100 {
//                    print("I am enter the dangerous")
//                    reginLocation.isEnter = true
//                    return
//                }else{
//                    print("I am leave the dangerous")
//                    reginLocation.isEnter = false
//                }
//            }
           
        }
    }
    
}
