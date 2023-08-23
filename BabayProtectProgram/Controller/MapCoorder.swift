//
//  GeoMapViewController.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/17.
//

import Foundation
import MapKit
import CoreLocation

//地图界面交互
class MapViewCoordinator: NSObject, CLLocationManagerDelegate {
    
    var viewController: UIViewController?
    //地图View
    var mapView: MKMapView!
//    var mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    //所有的围栏
    var geofencings: [GeoFencingViewModel] = []
    var locationManager: CLLocationManager?
    var streeName: StreeName
    var lastLocation = CLLocationCoordinate2D()
    
    init(geofencings: [GeoFencingViewModel], streeName: StreeName) {
        
        self.geofencings = geofencings
        self.streeName = streeName
        
    }
    
    func loadUI() {
        
        mapView.showsUserLocation = true
        lastLocation = mapView.userLocation.coordinate
        viewController?.view.addSubview(mapView)
        print("loadUI success")
        
    }
    
    //创建一个方法为所有的围栏添加半圆颜色
    func addRadiusOverlay(forGeotification geotification: [GeoFencingViewModel]) {
        for geofencing in geofencings {
            mapView.addOverlay(MKCircle(center: geofencing.coordinate, radius: geofencing.radius))
            print("addGeo")
            startMonitoring(geofencing: geofencing)
        }
    }
    
    //创建一个创建孩子位置的Annotation
    func addChildAnnotaion(childLocation: CLLocationCoordinate2D) {
        mapView.removeAnnotations(mapView.annotations)
        let childAnnotation = MKPointAnnotation()
        childAnnotation.coordinate = childLocation
        childAnnotation.title = "您的孩子"
        mapView.addAnnotation(childAnnotation)
    }
    
    func startMonitoring(geofencing: GeoFencingViewModel) {
        let fenceRegion = geofencing.region
        locationManager?.startMonitoring(for: fenceRegion)
    }
    
    func checkIfLocationServiesIsEnabled(){
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        mapView.delegate = self
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
            mapView.region = MKCoordinateRegion(center: locationManager.location!.coordinate,span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            //            print("check the location: \(mapRegion)")
        @unknown default:
            break
        }
        
    }
    
    //监控地理位置授权状态的时候情况处理
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    //地理围栏监测
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        let alertController = UIAlertController(title: "提示", message: "您已进入指定区域！", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
        alertController.addAction(okAction)
        // 在当前视图控制器中显示提示框
        viewController?.present(alertController, animated: true, completion: nil)
    }
    
    //定位自己的位置
    func zoomLocation() {
        mapView.zoomToLocation(mapView.userLocation.location)
    }
    
    //定位孩子的位置
    func zoomToChildLocation(lastLocation: LastLocation) {
        mapView.zoomToLocation(CLLocation(latitude: lastLocation.lastCoordinate.center.latitude, longitude: lastLocation.lastCoordinate.center.longitude))
        print("lastLocation: \(lastLocation.lastCoordinate)")
    }
    
    
    //实现导航路径绘制功能（通过不同的交通方式进行绘制）
    func navigationFunction(transportation: MKDirectionsTransportType,yourLocation: CLLocationCoordinate2D,childLocation: CLLocationCoordinate2D) {
        let yourLocation = MKPlacemark(coordinate: yourLocation)
        let childLocation = MKPlacemark(coordinate: childLocation )
        
        let youMapItem = MKMapItem(placemark: yourLocation)
        
        let childMapItem = MKMapItem(placemark: childLocation)
        
        let request = MKDirections.Request()
        request.source = youMapItem
        request.destination = childMapItem
        
        request.transportType = transportation
        
        let directions = MKDirections(request: request)
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
    
    
    
    //根据地理位置显示最近的街道名称
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.last?.coordinate {
            let geocoder = CLGeocoder()
            let location = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                if let placemark = placemarks?.first {
                    if let street = placemark.thoroughfare, let city = placemark.locality {
                        self.streeName.streeName = "\(street), \(city)"
                        print("locationName\(street),\(city)")
                    } else {
                        self.streeName.streeName = "Location Not Found"
                    }
                } else {
                    self.streeName.streeName = "Location Not Found"
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
    
}


extension MapViewCoordinator: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let circleRenderer = MKCircleRenderer(overlay: overlay)
            circleRenderer.lineWidth = 1.0
            circleRenderer.strokeColor = .purple
            circleRenderer.fillColor = UIColor.purple.withAlphaComponent(0.4)
            print("添加OVERLay成功了")
            return circleRenderer
        }
        
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

extension MKMapView {
    func zoomToLocation(_ location: CLLocation?) {
        guard let coordinate = location?.coordinate else { return }
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10_000, longitudinalMeters: 10_000)
        setRegion(region, animated: true)
    }
}
