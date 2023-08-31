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
    @StateObject var dataInfo = DataInfo()
    @State var dataInfos: [DataInfo] = []
    @State var isContain = false
    @StateObject var geoCloudStore = GeoCloudStoreModel()
    
    @State var noContact = false
    @StateObject var nowBeaconName = NowBeaconName()
    
    var model = ViewModelWatch()
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                BeaconDetectView(bluetoothModel: bluetool, beaconsNames: beaconModel, isContain: $isContain, nowBeaconName: nowBeaconName)
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
                            CallPhoneView(contactsModel: contactsModel, noContact: $noContact)
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
                    
//                    NavigationLink {
//                        GeoTest()
//                    } label: {
//                        Text("MAP")
//                    }


                }
                .padding(.top)
            }
            .sheet(isPresented: $isContain, content: {
                WarningView(dangerousType: .beacon, phone: contactsModel.contacts.count > 0 ? contactsModel.contacts[0].phoneNumber : "请添加号码", name: nowBeaconName.name)
                    .onAppear(perform: {
                        //暂停搜索
                        bluetool.stopScan()
                        
                    })
                    .onDisappear(perform: {
                        DispatchQueue.main.asyncAfter(deadline: .now()){
                            isContain = false
                        }
//                        isContain = false
                        bluetool.scanForPeripherals()
                    })
            })
            
            .sheet(isPresented: $locationManager.reginLocation.isEnter) {
                WarningView(dangerousType: .geofencation, phone: contactsModel.contacts.count > 0 ? contactsModel.contacts[0].phoneNumber : "请添加号码", name: "危险区")
                    .onAppear {
                        geoCloudStore.sendTheInformation(locationManager: locationManager)
                    }
            }
        }
        
        .task {
            do {
                try await contactsModel.fetchContacts()
                if contactsModel.contacts.count > 0 {
                    noContact = false
                }else{
                    noContact = true
                }
                print("Contacts fetched successfully")
            } catch {
                print("Error fetching contacts: \(error)")
            }

            do {
                try await geoCloudStore.fetchInformation()
                print("Geo information fetched successfully")
            } catch {
                print("Error fetching geo information: \(error)")
            }
            
        }
       
        .onAppear {
//            bluetool.startScanningTimer()
            Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { tiemr in
                sendLocationData()
            }
            
            readTheData()
            if DataManager.isFirstRuning() {
                print("yes")
            }else{
                sendLocationData()
            }
            
        }
    }
    
    func readTheData() {
        for info in DataManager.readData() {
            print("DataManager: --\(info.location)")
        }
        print("datacount: \(DataManager.readData().count)")
    }
    
    
    func sendLocationData() {
        let locations = LastLocation()
        locations.location.latitude = locationModel.userLocation?.latitude ?? 0.0
        locations.location.longitude = locationModel.userLocation?.longitude ?? 0.0
        locations.location.street_name = locationModel.locationName ?? "上海南站"
        print("locations.location.street_name \(locations.location.street_name)")
        
        print("lastLocation \(locations.location)")
        dataInfo.location = CLLocationCoordinate2D(latitude: locations.location.latitude, longitude: locations.location.longitude)
        dataInfos.append(dataInfo)
        let locationCloudStore = LocationCloudStroe()
        locationCloudStore.saveRecordToCloud(location: locations)
        print("send location data")
        
        DataManager.writeDate(dataInfoArr: dataInfos)
        print("DataManagerCount: -- \(dataInfos.count)")

    }
    
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(healthModel: HealthModel(), locationModel: LocationModel())
    }
}
