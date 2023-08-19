//
//  MapViewWaper.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/19.
//

import Foundation
import MapKit
import UIKit

class MapViewWrapper: ObservableObject {
    @Published var mapVew = MKMapView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
}
