//
//  TransferService.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/26.
//

import Foundation
import CoreBluetooth

struct TransferService{
    static let serviceID =  CBUUID(string: "6E400001-B5A3-F393-E0A9-E50E24DCCA9E")
    static let characteristicUUID = CBUUID(string: "6E400004-B5A3-F393-E0A9-E50E24DCCA9E")
}
