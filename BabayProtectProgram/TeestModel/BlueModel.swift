//
//  BlueModel.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/26.
//

import Foundation
import SwiftUI
import CoreBluetooth

class BluetoothModel: NSObject, ObservableObject {
    private var centralManager: CBCentralManager?
    @Published var peripherals: [CBPeripheral] = []
    private var timer: Timer?
    
    @Published var peripheralNames: [UUID: String] = [:]
    @Published var rssi: [UUID: NSNumber] = [:]
    @Published var isStart = true
    @Published var raweData: [UUID: String] = [:]
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
        // Start the timer when the BluetoothModel is initialized
//        startScanningTimer()
    }
    
    private func startScanningTimer() {
        // Schedule the timer to scan every 2 seconds
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { [weak self] _ in
            if ((self?.isStart) == true) {
                self?.scanForPeripherals()
            }
        }
    }
    
    
    func scanForPeripherals() {
        if centralManager?.state == .poweredOn {
            // Clear the peripherals list before each scan
            peripherals.removeAll()
            peripheralNames.removeAll()
            rssi.removeAll()
            // Start scanning for peripherals
            self.centralManager?.scanForPeripherals(withServices: nil)
        }
    }
    
    func stopScan() {
        self.centralManager?.stopScan()
    }
    
    deinit {
        // Invalidate the timer when the BluetoothModel is deallocated
        timer?.invalidate()
    }
    
    
}

extension BluetoothModel: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        if central.state == .poweredOn {
            //扫描设备
//            self.centralManager?.stopScan()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if  !peripherals.contains(peripheral){
            
            self.peripherals.append(peripheral)
            self.peripheralNames.updateValue(peripheral.name ?? "", forKey: peripheral.identifier)
            self.rssi.updateValue(RSSI, forKey: peripheral.identifier)
            if let rawData = advertisementData[CBAdvertisementDataServiceDataKey] as? String {
                print("rawData\(rawData)")
                self.raweData.updateValue(String(rawData), forKey: peripheral.identifier)
//                    let rawDataString = rawData.map { String(format: "%02x", $0) }.joined()
//                   self.raweData.updateValue(rawDataString, forKey: peripheral.identifier)
//                print("raweDatakey === \(peripheral.identifier),raweData === \(self.raweData[peripheral.identifier])")
           
            }
            
            
            for (key,value) in self.peripheralNames {
                if value == "" {
                    self.peripheralNames.removeValue(forKey: key)
                }
            }
            
//            print("//add device\(Date())")
            if (peripheral.name != nil) {
//                print("peripheral.name\(peripheral.name)")
            
            }

            
        }
    }
    
    
    //发送AT指令
    func sendATCommand(_ command: String) {
        for peripheral in peripherals {
            if let characteristic = peripheral.services?.first?.characteristics?.first(where: { $0.uuid == TransferService.characteristicUUID }) {
                            if characteristic.properties.contains(.write) {
                                if let data = command.data(using: .utf8) {
                                    peripheral.writeValue(data, for: characteristic, type: .withResponse)
                                } else {
                                    print("Failed to convert command to data")
                                }
                            } else {
                                print("Characteristic does not support write")
                            }
                        } else {
                            print("Characteristic not found")
                        }
        }
    }
    
    func connectedTheDevice(name: String) -> Bool {
        for peripheral in peripherals {
            if peripheral.name == name {
                self.centralManager?.connect(peripheral)
                return true
            }
        }
        return false
    }
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("connected")
        print("peripheral.name\(peripheral.name)")
        peripheral.delegate = self
        let servicesUUID = CBUUID(string: "6E400001-B5A3-F393-E0A9-E50E24DCCA9E")
        peripheral.discoverServices([servicesUUID])
    }
    
}


extension BluetoothModel: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let service = peripheral.services?.first(where: { $0.uuid.uuidString == "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"}) {
            print("yes i find the service")
            let characteristicUUID = CBUUID(string: "6E400004-B5A3-F393-E0A9-E50E24DCCA9E")
            peripheral.discoverCharacteristics([characteristicUUID], for: service)
        }
    }
//    6E400004B5A3F393E0A9E50E24DCCA9E
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristic = service.characteristics?.first(where: { $0.uuid.uuidString == "6E400004-B5A3-F393-E0A9-E50E24DCCA9E"}) {
            print("yes i find the characteristic")
            
            if characteristic.properties.contains(.write) {
              
//                let data = "AT+NAME=".data(using: .utf8)
//                peripheral.writeValue(data!, for: characteristic, type: .withResponse)
                
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        if let data = characteristic.value, let response = String(bytes: data, encoding: .utf8) {
                print("Received response: \(response)")
                if response.hasPrefix("AT+NAME?") {
                    let deviceName = response.replacingOccurrences(of: "AT+NAME?", with: "")
                    print("Device name: \(deviceName)")
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
                    print("Write failed with error: \(error)")
                } else {
                    print("Write succeeded!")
                    print("characteristic.value\(characteristic.value)")
        }
        
    }
    
}

struct Device: Identifiable {
    var id = UUID()
    var name: String
    var uuid: String
}
