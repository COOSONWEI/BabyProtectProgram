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
    @State var dangerType = DangerousType.self
    @StateObject var locationManager = LocationManager()
    
    @StateObject var healehCloudStore = HealthiCloudStore()
    
    @State var isContain = false
    var model = ViewModelWatch()
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                BeaconDetectView(bluetoothModel: bluetool, beaconsNames: beaconModel, isContain: $isContain)
                    .sheet(isPresented: $isContain, content: {
                        WarningView(dangerousType: .beacon, phone: contactsModel.contacts.count > 0 ? contactsModel.contacts[0].phoneNumber : "请添加号码")
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
            .sheet(isPresented: $locationManager.reginLocation.isEnter) {
                WarningView(dangerousType: .geofencation, phone: contactsModel.contacts.count > 0 ? contactsModel.contacts[0].phoneNumber : "请添加号码")
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
        }
    }
    
    func sendLocationData() {
        let locations = LastLocation()
        locations.location.latitude = locationModel.userLocation?.latitude ?? 0.0
        locations.location.longitude = locationModel.userLocation?.longitude ?? 0.0
        locations.location.street_name = locationModel.locationName ?? "上海南站"
        print("lastLocation \(locations.location)")
        
        let locationCloudStore = LocationCloudStroe()
        locationCloudStore.saveRecordToCloud(location: locations)
        print("send location data")
        
    }
    
    
    
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(healthModel: HealthModel(), locationModel: LocationModel())
    }
}
