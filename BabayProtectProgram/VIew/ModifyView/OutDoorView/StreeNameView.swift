//
//  StreeNameView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/24.
//

import SwiftUI
import MapKit

struct StreeNameView: View {
    @State private var streetAddress = ""
    @State private var isNavigationSheetPresented = false
    
    var body: some View {
        VStack {
            TextField("Enter Street Address", text: $streetAddress)
                .padding()
            
            Button("Navigate") {
                navigateToAddress()
            }
        }
        .sheet(isPresented: $isNavigationSheetPresented, content: {
            NavigationView {
                MapView(destination: streetAddress)
                    .navigationBarTitle("Navigation")
            }
        })
    }
    
    func navigateToAddress() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(streetAddress) { placemarks, error in
            
            if let error = error {
                print("Error")
            }
            
            if let placemark = placemarks?.first,
               let location = placemark.location {
                openMapsNavigation(destination: location.coordinate)
            }
        }
    }
    
    func openMapsNavigation(destination coordinate: CLLocationCoordinate2D) {
        let destinationPlacemark = MKPlacemark(coordinate: coordinate)
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
        destinationItem.name = "Destination"
        
        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        MKMapItem.openMaps(with: [destinationItem], launchOptions: options)
    }
}

struct MapView: UIViewRepresentable {
    let destination: String
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(destination) { placemarks, error in
            if let placemark = placemarks?.first,
               let location = placemark.location {
                let annotation = MKPointAnnotation()
                annotation.coordinate = location.coordinate
                annotation.title = "Destination"
                uiView.addAnnotation(annotation)
                
                let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                uiView.setRegion(region, animated: true)
            }
        }
    }
}


struct StreeNameView_Previews: PreviewProvider {
    static var previews: some View {
        StreeNameView()
    }
}
