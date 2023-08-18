//
//  DrawingHistoryPath.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/19.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation

struct NavigationView: UIViewRepresentable {
    
    var sourceCoordinate: CLLocationCoordinate2D
    var destinationCoordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        context.coordinator.mapView = mapView
        context.coordinator.loadUI()
        mapView.delegate = context.coordinator
        
       
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
       
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(sourceCoordinate: sourceCoordinate, destinationCoordinate: destinationCoordinate)
    }
    
    //创建代理获取用户当前的位置
    class Coordinator: NSObject, CLLocationManagerDelegate,MKMapViewDelegate {
        
        var mapView: MKMapView?
        var sourceCoordinate: CLLocationCoordinate2D
        var destinationCoordinate: CLLocationCoordinate2D
        
        init(sourceCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
            self.sourceCoordinate = sourceCoordinate
            self.destinationCoordinate = destinationCoordinate
        }
        //创建Manager设置代理
        var locationManager: CLLocationManager?
        
        func checkIfLocationServiesIsEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager!.requestAlwaysAuthorization()
            locationManager!.startUpdatingLocation()
            mapView?.userTrackingMode = .follow
            print("checkIfTheLocationUseFul")
        }
        
        
        func loadUI() {
            mapView?.region = MKCoordinateRegion(center: sourceCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
            mapView?.showsUserLocation = true
            mapView?.delegate = self
            // Add source and destination annotations
            let sourceAnnotation = MKPointAnnotation()
            sourceAnnotation.coordinate = sourceCoordinate
            sourceAnnotation.title = "Start"
            mapView?.addAnnotation(sourceAnnotation)

            let destinationAnnotation = MKPointAnnotation()
            destinationAnnotation.coordinate = destinationCoordinate
            destinationAnnotation.title = "End"
            mapView?.addAnnotation(destinationAnnotation)
            
            print("courceCoorinatioe:\(sourceCoordinate)")
            // Calculate directions
            let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
            let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)

            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)

            let request = MKDirections.Request()
            request.source = sourceMapItem
            request.destination = destinationMapItem
            request.transportType = .automobile

            let directions = MKDirections(request: request)
            directions.calculate { response, error in
                guard let route = response?.routes.first else {
                    return
                }
                self.mapView?.addOverlay(route.polyline)
                print("add")
            }
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
                mapView?.region = MKCoordinateRegion(center: locationManager.location!.coordinate,span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    //            print("check the location: \(mapRegion)")
            @unknown default:
                break
            }
        }
        
        //监控地理位置授权状态的时候情况处理
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            checkLocationAuthorization()
        }
        
        //添加overlay的绘制委托
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let render = MKPolygonRenderer(overlay: overlay)
            render.strokeColor = .systemPink
            render.lineWidth = 5
            print("add overlay")
            return render
        }
       
        
    }
}

struct DrawingHistoryView: View {
    let sourceCoordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
    let destinationCoordinate = CLLocationCoordinate2D(latitude: 37.8049, longitude: -122.4708)

    var body: some View {
        NavigationView(sourceCoordinate: sourceCoordinate, destinationCoordinate: destinationCoordinate)
            .frame(height: 300)
    }
}

struct DrawingHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingHistoryView()
    }
}
