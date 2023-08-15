//
//  BeaconDetectView.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/9.
//

import SwiftUI
import CoreBluetooth

struct BeaconDetectView: View {
    @StateObject var bluetoothModel: BluetoothModel
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
                        if bluetoothModel.peripheralNames.values.contains("houseroom") {
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
            .navigationTitle("菜单")
            
        }
    }
}

struct BeaconDetectView_Previews: PreviewProvider {
    static var previews: some View {
        BeaconDetectView(bluetoothModel: BluetoothModel(), isContain: .constant(false))
    }
}
