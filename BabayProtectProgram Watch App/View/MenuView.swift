//
//  MenuView.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/9.
//

import SwiftUI
import WatchKit

struct MenuView: View {
    @StateObject var healthModel: HealthModel
    @StateObject var bluetool = BluetoothModel()
    @StateObject var beaconModel = CloudBeaconModel()
    @StateObject var contactsModel = Contacts()
    @StateObject var locationModel: LocationModel
    @StateObject var locationCloudStroe = LocationCloudStroe()
    
    @StateObject var healehCloudStore = HealthiCloudStore()
    
    @State var isContain = false
    var model = ViewModelWatch()
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                BeaconDetectView(bluetoothModel: bluetool, beaconsNames: beaconModel, isContain: $isContain)
                    .sheet(isPresented: $isContain, content: {
                        WarningView()
                            .onDisappear(perform: {
                                isContain = false
                                bluetool.scanForPeripherals()
                            })
                    })
                    .opacity(0)
                    .task {
                        do {
                            try await beaconModel.fetchBeacons()
                        }catch {
                            print("fail to loaded")
                        }
                    }
                    
                VStack(spacing: 15){
                    HStack(spacing: 18){
                        NavigationLink {
                            CallPhoneView(contactsModel: contactsModel)
                        } label: {
                            MenuRow(image: "CallPhone")
                            
                        }
                        .frame(width: 75, height:75)

                        NavigationLink {
                            HealthView(healthModel: healthModel)
                        } label: {
                            MenuRow(image: "Health")
                        }
                        .frame(width: 75, height:75)
                    }
                   
//                    HStack(spacing:18){
//                        NavigationLink {
//
//                        } label: {
//                            MenuRow(image: "Message")
//                        }
//                        .frame(width: 75, height:75)
//
//                        NavigationLink {
//
//                        } label: {
//                           MenuRow(image: "CallFast")
//                        }
//                        .frame(width: 75, height:75)
//
//                    }
                }
                .padding(.top)
            }
        }
        .task {
            do{
                try await contactsModel.fetchContacts()
            } catch {
                print("cont FetchIt")
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { tiemr in
                sendLocationData()
            }
           sendHealthData()
        }
    }
    
    func sendLocationData() {
        let locations = LastLocation()
        locations.location.latitude = locationModel.userLocation?.latitude ?? 0.0
        locations.location.longitude = locationModel.userLocation?.longitude ?? 0.0
        locations.location.street_name = locationModel.locationName ?? "上海南站"
        
        let locationCloudStore = LocationCloudStroe()
        locationCloudStore.saveRecordToCloud(location: locations)
        print("send location data")
        
    }
    
    func sendHealthData() {
        let healthData = HealthModel()
        healthData.walkStep = healthModel.walkStep
        healthData.distance = healthModel.distance
        healthData.heartRate = healthModel.heartRate
        healthData.RestingHeartRate = healthModel.RestingHeartRate
        healthData.sleepTime = healthModel.sleepTime
        healthData.todayCalorie = healthModel.todayCalorie
        healthData.todayTime = healthModel.todayTime
        
        let healthCloudStore = HealthiCloudStore()
        healthCloudStore.saveRecordToCloud(health: healthData)
        print("send health data")
        print(" \(healthData.walkStep),\(healthData.distance ),\(healthData.heartRate  ),\(healthData.RestingHeartRate ),\(healthData.sleepTime),\(healthData.todayCalorie ),\(healthData.todayTime)")
    }
    
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(healthModel: HealthModel(), locationModel: LocationModel())
    }
}
