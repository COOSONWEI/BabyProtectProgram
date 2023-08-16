//
//  BeaconDetectView.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/9.
//

import SwiftUI
import CoreBluetooth
import WatchConnectivity

struct BeaconDetectView: View {
    @Environment(\.managedObjectContext) var context
    @StateObject var bluetoothModel: BluetoothModel
    @StateObject var beaconsNames: CloudBeaconModel
    @Binding var isContain: Bool
    
    var body: some View {
        
        NavigationView {
            List{
                ForEach(Array(bluetoothModel.peripheralNames.keys),id:\.self){ key in
                    
                    VStack{
                        Text("name:\(bluetoothModel.peripheralNames[key] ?? "")")
                        Text("UUID:\(key)")
                        Text("Rssi: \(bluetoothModel.rssi[key] ?? 0)")
                    }
                    .task {
                        do{
                           try await respondBeacon()
                        }catch{
                            print("加载错误")
                        }
                    }
                    
                }
            }
            .navigationTitle("菜单")
            
        }
    }
    
    func respondBeacon() async throws{
        for (beacon,_) in beaconsNames.usefulBeaconNames {
            //                            print("beaconName:\(beacon.object(forKey: "beaconsName") as! String)")
            if bluetoothModel.peripheralNames.values.contains(beacon) {
                vibrateWatch()
                print("I Find It ")
                try await save(beacon: beacon)
                bluetoothModel.isStart = false
                isContain = true
            } else {
                bluetoothModel.isStart = true
                isContain = false
            }
        }
    }
    
//    func sendNotificaiton() {
//
//    }
    
    private func save(beacon: String) async throws {
       let beaconData = BeaconModel()
        beaconData.beaconName.name = beacon
        do {
            try context.save()
            print("CloudBeaconModel Save Scuceess...")
        }catch {
            print("Failed to save the record...")
            print(error.localizedDescription)
        }
        let cloudStore = CloudBeaconModel()
        try await cloudStore.updateBeaconRecord(beaconName: beaconData.beaconName.name)
    }
    
    func vibrateWatch() {
           let device = WKInterfaceDevice.current()
           
        //使用震动通知功能
            device.play(.notification)
       }
}

struct BeaconDetectView_Previews: PreviewProvider {
    static var previews: some View {
        BeaconDetectView(bluetoothModel: BluetoothModel(), beaconsNames: CloudBeaconModel(), isContain: .constant(false))
    }
}
