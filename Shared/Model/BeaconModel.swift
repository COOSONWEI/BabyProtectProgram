//
//  BeaconModel.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/13.
//

import Foundation
import SwiftUI

struct Beacon: Hashable {
    let id = UUID()
    let uuid: String
    let name: String
}

//创建信标的数据模型
class BeaconModel: NSObject, ObservableObject {
    @Published var beacons = [Beacon]()
}




