//
//  FindingAndSettingBeaconView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/27.
//

import SwiftUI

struct FindingAndSettingBeaconView: View {
    
    @StateObject var bluetoothModel: BluetoothModel
    
    @State var startScan = false
    @State var connectSuccess = false
    @State var sheetView = false
    @State var uuid = ""
    @State var name = ""
    
    var body: some View {
        
        
        VStack{
            
            
            HStack{
                VStack(alignment:.leading){
                    
                    Text("扫描设备")
                        .font(
                            Font.custom("PingFang SC", size: 28)
                                .weight(.medium)
                        )
                        .kerning(1.4)
                        .foregroundColor(Color(red: 0.32, green: 0.32, blue: 0.32))
                    
                    Text("正在扫描附近的蓝牙设备...")
                    
                }
                .padding(.leading)
                Spacer()
            }
            
            List{
                ForEach(Array(bluetoothModel.peripheralNames.keys),id:\.self){ key in
                    ZStack{
                        BeaconCardView(name: "\(bluetoothModel.peripheralNames[key] ?? "")", uuid: "\(key)")
                        NavigationLink(destination: BeaconDetailView(uuid: $uuid, name: $name,bluetoolth: bluetoothModel)
                            .navigationBarBackButtonHidden(true)
                            .navigationBarItems(leading: BackButtonView())
                            .onAppear {
                                print("On Appear")
                                bluetoothModel.stopScan()
                              
                                uuid = key.uuidString
                                name = bluetoothModel.peripheralNames[key] ?? "nil"
                                
                                connectSuccess = bluetoothModel.connectedTheDevice(name: bluetoothModel.peripheralNames[key] ?? "")
                            }, label: {Text("")}).opacity(0) //覆盖掉默认的箭头
                    }
                   
                }
            }
            .listStyle(.plain)

        }
        .onAppear {
            bluetoothModel.scanForPeripherals()
        }
        .onDisappear {
            bluetoothModel.stopScan()
        }
        
    }
    
}

struct FindingAndSettingBeaconView_Previews: PreviewProvider {
    static var previews: some View {
        FindingAndSettingBeaconView(bluetoothModel: BluetoothModel())
    }
}
