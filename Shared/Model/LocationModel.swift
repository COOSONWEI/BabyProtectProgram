//
//  LocationModel.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/12.
//

import Foundation
import MapKit

//获取设备的地理位置
class LocationModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var locationName: String?
    
    @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.1, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    func checkIfLocationServiesIsEnabled(){
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.requestAlwaysAuthorization()
        locationManager!.startUpdatingLocation()
    }
    
    func checkLocationAuthorization() {
        guard let locationManager = locationManager else {return}
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .restricted:
            print("You location is restricted likely due to parental controls")
        case .denied:
            print("you have denied thi s app location permission, go into setting to change it")
        case .authorizedAlways, .authorizedWhenInUse:
//            mapRegion = MKCoordinateRegion(center: locationManager.location!.coordinate,span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            print("check the location: \(mapRegion)")
        @unknown default:
            break
        }
    
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
       checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let userLocation = locations.last?.coordinate {
                self.userLocation = userLocation
                print("userLocation is \(userLocation)")
                let geocoder = CLGeocoder()
                let location = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
                geocoder.reverseGeocodeLocation(location) { placemarks, error in
                    if let error = error {
                           print("Error calculating directions: \(error.localizedDescription)")
                           return
                       }
                    if let placemark = placemarks?.first {
                        print("placemark: \(placemark)")
                        if let street = placemark.thoroughfare, let city = placemark.locality {
                            self.locationName = "\(street), \(city)"
                            print("locationName\(street),\(city)")
                        } else {
                            self.locationName = "\(placemark)"
                        }
                    } else {
                        self.locationName = "Location Not Found"
                    }
                }
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Location error: \(error.localizedDescription)")
        }
    
    
}
