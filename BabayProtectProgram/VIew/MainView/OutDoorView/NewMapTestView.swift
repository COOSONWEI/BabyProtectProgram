//
//  NewMapTestView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/24.
//

import SwiftUI
import MapKit
import CoreLocation
//
//struct AnotationView: View {
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // San Francisco
//        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//    )
//
//    // Define the coordinates of the polygon vertices
//    let polygonCoordinates: [CLLocationCoordinate2D] = [
//        CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
//        CLLocationCoordinate2D(latitude: 37.8049, longitude: -122.4094),
//        CLLocationCoordinate2D(latitude: 37.8049, longitude: -122.4394)
//        // Add more coordinates as needed
//    ]
//
//    var body: some View {
//        Map(coordinateRegion: $region, showsUserLocation: false, userTrackingMode: .none, annotationItems: []) { _ in
//            // Add the polygon overlay to the map
//            Polygon(coordinates: polygonCoordinates)
//        }
//    }
//}
//
//// Custom Polygon shape
//struct Polygon: Shape {
//    var coordinates: [CLLocationCoordinate2D]
//
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//        if let startPoint = coordinates.first {
//            path.move(to: CGPoint(x: startPoint.longitude, y: startPoint.latitude))
//
//            for coordinate in coordinates.dropFirst() {
//                path.addLine(to: CGPoint(x: coordinate.longitude, y: coordinate.latitude))
//            }
//
//            path.closeSubpath()
//        }
//
//        return path
//    }
//}
