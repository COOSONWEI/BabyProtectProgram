//
//  BeaconDetectView.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/9.
//

import SwiftUI
import CoreBluetooth
import WatchConnectivity

class NowBeaconName: ObservableObject {
    @Published var name = ""
}



struct BeaconDetectView: View {
    @Environment(\.managedObjectContext) var context
    @StateObject var bluetoothModel: BluetoothModel
    @StateObject var beaconsNames: CloudBeaconModel
    @Binding var isContain: Bool
    @StateObject var nowBeaconName: NowBeaconName
    
    var body: some View {
        NavigationView {
            ScrollViewReader { scrollViewProxy in
                List {
                    let keysArray = Array(bluetoothModel.peripheralNames.keys) // 将键集合转换为数组
                    ForEach(keysArray, id: \.self) { key in
                        VStack {
                            Text("name: \(bluetoothModel.peripheralNames[key] ?? "")")
                            Text("UUID: \(key)")
                            Text("Rssi: \(bluetoothModel.rssi[key] ?? 0)")
                        }
                        .id(UUID()) // 为每个 VStack 添加唯一标识符
                        .task {
                            do {
                                try await respondBeacon()
                            } catch {
                                print("加载错误")
                            }
                        }
                        .onAppear {
                            // 在最后一个元素出现时滚动到底部
                            if key == keysArray.last {
                                withAnimation {
                                    scrollViewProxy.scrollTo(UUID(), anchor: .bottom)
                                }
                            }
                            print("listscroller")
                        }
                        .onDisappear {
                            // 在第一个元素消失时滚动到顶部
                            if key == keysArray.first {
                                withAnimation {
                                    scrollViewProxy.scrollTo(UUID(), anchor: .top)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("菜单")
            }
        }
    }
    
    
    func respondBeacon() async throws{
        for (beacon,_) in beaconsNames.usefulBeaconNames {
            //                            print("beaconName:\(beacon.object(forKey: "beaconsName") as! String)")
            if bluetoothModel.peripheralNames.values.contains(beacon) {
                
                vibrateWatch()
                print("I Find It")
                nowBeaconName.name = beacon
                bluetoothModel.isStart = false
                isContain = true
                try await save(beacon: beacon)
               
            }else {
                bluetoothModel.isStart = true
                isContain = false
            }
        }
    }
    
    
    
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
        BeaconDetectView(bluetoothModel: BluetoothModel(), beaconsNames: CloudBeaconModel(), isContain: .constant(false), nowBeaconName: NowBeaconName())
    }
}
