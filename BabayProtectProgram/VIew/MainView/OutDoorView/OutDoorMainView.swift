//
//  OutDoorMainView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/12.
//

import SwiftUI
import MapKit

//先用自己的手机的Location 先进行测试一下

struct OutDoorMainView: View {
    
    @State var back = false
//    @StateObject private var locationModel = LocationModel()
    @StateObject private var locationVM = LocationCloudStroe()
    @StateObject  var lastLocation = LastLocation()
    
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showSettings = false
    
    //it's test data
    var locations = [
            Location(name: "Location 1", coordinate: CLLocationCoordinate2D(latitude: 31.145506764721492, longitude: 121.31609839130479)),
            Location(name: "Location 2", coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4294)),
            // Add more locations...
        ]
    var body: some View {
        ZStack{
            Map(coordinateRegion: $lastLocation.lastCoordinate, interactionModes: .all, showsUserLocation: true, userTrackingMode: .none, annotationItems: locations) { item in
              
                MapMarker(coordinate: item.coordinate,tint: .pink)

            }
            .ignoresSafeArea()
            
//            Map(coordinateRegion: $lastLocation.lastCoordinate, showsUserLocation: true, userTrackingMode: .constant(.follow), annotations: [])
//                        .onAppear {
//                            let annotation = MKPointAnnotation()
//                            annotation.coordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
//                            annotation.title = "Custom Location"
//
//                            annotations.append(annotation)
//            }
        
            VStack{
                HStack(alignment:.center){
                    Button {
                        back.toggle()
                    } label: {
                        Image("backBT")
                            .resizable()
                            .frame(maxWidth: 27, maxHeight: 27)
                            .fixedSize()
                    }
                    
                    LocationView(locationModel: lastLocation)
                }
                
                HStack{
                    Spacer()
//                    OutDoorFunctionView(locationModel: locationModel)
//                        .padding(.top,28)
                }
                .padding(.trailing)
                
                Spacer()
            }
            
//
//            Button("View Settings") {
//                        showSettings = true
//                    }
//                    .sheet(isPresented: $showSettings) {
//                        AddDangerView()
//                            .presentationDetents([.medium, .large])
//            }
        }
        .task {
            do {
                try await locationVM.fetchRecord()
                lastLocation.lastCoordinate = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(locationVM.locationRecord[0].object(forKey: "latitude") as! String) ?? 0.0, longitude: Double(locationVM.locationRecord[0].object(forKey: "longitude") as! String) ?? 0.0), latitudinalMeters: 0.5, longitudinalMeters: 0.5)
                print( "lastLocation.lastCoordinate\(lastLocation.lastCoordinate)")
                print("loading successful")
            } catch {
                print("loading false")
            }
        }
        .onAppear(perform: {
            locationVM.fetchPolling()
        })
        .fullScreenCover(isPresented: $back) {
            HomeView()
        }
    }
        
    
}

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}


struct OutDoorMainView_Previews: PreviewProvider {
    static var previews: some View {
        OutDoorMainView()
    }
}
