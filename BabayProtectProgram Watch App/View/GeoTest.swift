//
//  GeoTest.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/18.
//
import SwiftUI
import CoreLocation
import MapKit

struct GeoTest: View {
    @StateObject var locationManager = LocationManager()
    @State private var showAlert = false
    @StateObject  var regin = ReginLocation()
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 37.36944548473393, longitude: -122.04533845875346)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 37.3349285, longitude: -122.011033))
    ]
    
    var body: some View {
        VStack {
            
            Map(coordinateRegion: $regin.locationsRegin, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: locations) { coordinate in
                MapMarker(coordinate: coordinate.coordinate)
            }
            
            Text("distance: \(locationManager.reginLocation.distance) M")
            
            Text( locationManager.reginLocation.isEnter ? "Enter" : "NoEnter")
            
        }
        
        
    }
}



struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    
}


struct GeoTest_Previews: PreviewProvider {
    static var previews: some View {
        GeoTest()
    }
}
