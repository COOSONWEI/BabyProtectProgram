//
//  NewBeaconTestView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/26.
//

import SwiftUI


// ... BluetoothModel and BluetoothDevice remain the same as in the previous example

struct NewBeaconTestView: View {
    @StateObject private var bluetoothModel = BluetoothModel()
    @State var connectSuccess = false
    var body: some View {
        NavigationView {
            List(0..<bluetoothModel.peripherals.count) { index in
                HStack {
                    Text(bluetoothModel.peripherals[index].name ?? "nil")
                    Spacer()
                    Button("Connect") {
                        connectSuccess = bluetoothModel.connectedTheDevice(name: bluetoothModel.peripherals[index].name ?? "nil")
                    }
                }
            }
            .alert(isPresented: $connectSuccess, content: {
                Alert(title: Text("成功"), message: Text("连接成功"))
            })
            .navigationTitle("Bluetooth Devices")
            .toolbar {
                Button("Scan") {
                    bluetoothModel.scanForPeripherals()
                }
            }
            
        }
    }
}

struct NewBeaconTestView_Previews: PreviewProvider {
    static var previews: some View {
        NewBeaconTestView()
    }
}
