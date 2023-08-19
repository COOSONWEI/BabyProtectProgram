//
//  HistoryPathViewController.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/19.
//

import Foundation
import MapKit
import CoreLocation


class HsitoryMapViewCoordinator:  NSObject,CLLocationManagerDelegate {
    
    var viewController: UIViewController?
    //地图View
    var mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    //起点和终点坐标
    var sourceCoordinate: CLLocationCoordinate2D
    var destinationCoordinate: CLLocationCoordinate2D
    
    
    init(sourceCoordinate: CLLocationCoordinate2D ,destinationCoordinate:  CLLocationCoordinate2D) {
        self.sourceCoordinate = sourceCoordinate
        self.destinationCoordinate = destinationCoordinate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func loadUI() {
        mapView.delegate = self
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 39.916345, longitude: 116.397155), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        
        mapView.setRegion(region, animated: true)
        viewController?.view.addSubview(mapView)
        print("load success")
    }
    
    func drawThePath() {
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.coordinate = sourceCoordinate
        sourceAnnotation.title = "Start"
        mapView.addAnnotation(sourceAnnotation)

        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.coordinate = destinationCoordinate
        destinationAnnotation.title = "End"
        mapView.addAnnotation(destinationAnnotation)
        
        print("courceCoorinatioe:\(sourceCoordinate)")
        // Calculate directions
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)

        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)

        let request = MKDirections.Request()
        request.source = sourceMapItem
        request.destination = destinationMapItem
        
        //交通工具的选择
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        
        print("directions: \(directions)")
        directions.calculate { response, error in
            if let error = error {
                   print("Error calculating directions: \(error.localizedDescription)")
                   return
               }
            
            guard let route = response?.routes.first else {
                return
            }
            self.mapView.addOverlay(route.polyline)
            print("add")
        }
    }

}

extension HsitoryMapViewCoordinator: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let ploygon = MKPolylineRenderer(overlay: overlay)
            ploygon.strokeColor = .systemPink
            ploygon.lineWidth = 5
            print("add overlay")
            return ploygon
        }
       return MKOverlayRenderer(overlay: overlay)
      
    }
}


