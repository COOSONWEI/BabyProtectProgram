//
//  BeaconConectTestView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/26.
//

import SwiftUI

import CoreBluetooth
import WatchConnectivity

struct BeaconDetectView: View {
    @Environment(\.managedObjectContext) var context
    @StateObject var bluetoothModel: BluetoothModel
    
    @State var startScan = false
    @State var connectSuccess = false
    @State var sheetView = false
    @State var uuid = ""
    @State var name = ""
    
    var body: some View {
        
        NavigationView {
            
            VStack{
                List{
                    ForEach(Array(bluetoothModel.peripheralNames.keys),id:\.self){ key in
                        VStack(alignment: .center){
                            
                            Text("name:\(bluetoothModel.peripheralNames[key] ?? "")")
                            Text("UUID:\(key)")
                            Text("Rssi: \(bluetoothModel.rssi[key] ?? 0)")
                            Text("Data:\(bluetoothModel.raweData[key] ?? "nil")")
                            
                            Button {
                                uuid = key.uuidString
                                name = bluetoothModel.peripheralNames[key] ?? "nil"
                                
                                connectSuccess = bluetoothModel.connectedTheDevice(name: bluetoothModel.peripheralNames[key] ?? "")
                                if connectSuccess {
                                    sheetView = true
                                }else {
                                    sheetView = false
                                }
                            } label: {
                                Text("连接")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
                .navigationTitle("菜单")
//                .alert(isPresented: $connectSuccess) {
//                    Alert(title: Text("提示"), message: Text("连接成功"))
//                }
                .sheet(isPresented: $connectSuccess) {
                    ConnectDetailView(uuid: $uuid, name: $name,bluetoolth: bluetoothModel)
                }
                
                Button {
                    startScan.toggle()
                    if startScan {
                        bluetoothModel.peripheralNames.removeAll()
                        bluetoothModel.rssi.removeAll()
                        bluetoothModel.raweData.removeAll()
                        bluetoothModel.peripherals.removeAll()
                        bluetoothModel.scanForPeripherals()
                    }else{
                        bluetoothModel.stopScan()
                    }
                } label: {
                    Text(startScan ? "停止扫描" : "开始扫描")
                        .foregroundColor(.black)
                }
            }
           
        }
        
    }
    

}

struct BeaconDetectView_Previews: PreviewProvider {
    static var previews: some View {
        BeaconDetectView(bluetoothModel: BluetoothModel())
    }
}

