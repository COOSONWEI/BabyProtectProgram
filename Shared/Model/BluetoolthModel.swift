//
//  BluetoolthModel.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/9.
//

import Foundation
import SwiftUI
import CoreBluetooth

class BluetoothModel: NSObject, ObservableObject {
    private var centralManager: CBCentralManager?
    private var peripherals: [CBPeripheral] = []
    private var timer: Timer?
    
    @Published var peripheralNames: [UUID: String] = [:]
    @Published var rssi: [UUID: NSNumber] = [:]
    @Published var isStart = true
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
        // Start the timer when the BluetoothModel is initialized
        startScanningTimer()
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
    
    deinit {
        // Invalidate the timer when the BluetoothModel is deallocated
        timer?.invalidate()
    }
}

extension BluetoothModel: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        if central.state == .poweredOn {
            //扫描设备
            peripherals.removeAll()
            peripheralNames.removeAll()
            rssi.removeAll()
            // Start scanning for peripherals
            self.centralManager?.scanForPeripherals(withServices: nil)
            print("//扫描设备\(Date())")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if  !peripherals.contains(peripheral){
            
            self.peripherals.append(peripheral)
            self.peripheralNames.updateValue(peripheral.name ?? "", forKey: peripheral.identifier)
            self.rssi.updateValue(RSSI, forKey: peripheral.identifier)
            for (key,value) in self.peripheralNames {
                if value == "" {
                    self.peripheralNames.removeValue(forKey: key)
                }
            }
//            print("//add device\(Date())")
            if (peripheral.name != nil) {
//                print("peripheral.name\(peripheral.name)")
            
            }
//            if peripherals.count > 50 {
//                self.scanForPeripherals()
//            }
        }
    }
}

struct Device: Identifiable {
    var id = UUID()
    var name: String
    var uuid: String
}
