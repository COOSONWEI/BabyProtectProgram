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
    @StateObject var bluetoothModel: BluetoothModel
    @StateObject var beaconsNames: BeaconModel
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
                    .onAppear {
                        for beacon in beaconsNames.usefulBeaconNames {
                            //                            print("beaconName:\(beacon.object(forKey: "beaconsName") as! String)")
                            if bluetoothModel.peripheralNames.values.contains(beacon) {
                                vibrateWatch()
                                print("I Find It ")
                                bluetoothModel.isStart = false
                                isContain = true
                            } else {
                                bluetoothModel.isStart = true
                                isContain = false
                            }
                        }
                        
                    }
                }
            }
            .navigationTitle("菜单")
            
        }
    }
    
    func vibrateWatch() {
           let device = WKInterfaceDevice.current()
           
        //使用震动通知功能
            device.play(.notification)
       }
}

struct BeaconDetectView_Previews: PreviewProvider {
    static var previews: some View {
        BeaconDetectView(bluetoothModel: BluetoothModel(), beaconsNames: BeaconModel(), isContain: .constant(false))
    }
}
