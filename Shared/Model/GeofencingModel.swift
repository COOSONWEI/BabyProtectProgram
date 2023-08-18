//
//  GeofencingModel.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/17.
//

import Foundation
import CoreLocation
import MapKit


//地理信息系统路径
class GeoFencingViewModel: NSObject, ObservableObject, MKAnnotation {
    //事件处理类型(目前是进入)
    enum EventType: String {
        case onEnter = "onEntery"
    }
    
    //编码的键的类型
    // 目前是经纬度，范围半径、id（这里可以理解为围栏的名称）
    enum CodingKeys: String, CodingKey {
        case latitude, longitude, radius, identifier, note, eventType
    }
    
    // 地理围栏的属性
    var coordinate: CLLocationCoordinate2D
    var radius: CLLocationDistance
    var identifier: String
    //通知的内容
    var note: String
    var eventType: EventType
    
    var title: String? {
        if note.isEmpty {
            return "No Name"
        }
        return note
    }
    
    var subtitle: String? {
       let eventTypeString = eventType.rawValue
       let formatter = MeasurementFormatter()
       formatter.unitStyle = .short
       formatter.unitOptions = .naturalScale
       let radiusString = formatter.string(from: Measurement(value: radius, unit: UnitLength.meters))
       return "Radius: \(radiusString) - \(eventTypeString)"
     }
    
    //设定最大半径
    func clampRadius(maxRadius: CLLocationDegrees) {
       radius = min(radius, maxRadius)
    }
    
    init(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance, identifier: String, note: String, eventType: EventType) {
        self.coordinate = coordinate
        self.radius = radius
        self.identifier = identifier
        self.note = note
        self.eventType = eventType
    }

    
}

// MARK: - Notification Region
extension GeoFencingViewModel {
  var region: CLCircularRegion {
    // 1
    let region = CLCircularRegion(
      center: coordinate,
      radius: radius,
      identifier: identifier)

    // 2
    region.notifyOnEntry = (eventType == .onEnter)
      print("region is true")
    region.notifyOnExit = !region.notifyOnEntry
    return region
  }
}



