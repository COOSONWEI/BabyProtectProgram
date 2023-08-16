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
    @StateObject private var locationModel = LocationModel()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showSettings = false
    
    //it's test data
    var locations = [
            Location(name: "Location 1", coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)),
            Location(name: "Location 2", coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4294)),
            // Add more locations...
        ]
    var body: some View {
        ZStack{
            Map(coordinateRegion: $locationModel.mapRegion,showsUserLocation: true)
            
                .tint(.pink)
                .ignoresSafeArea()
            
                .onAppear {
                    
                    locationModel.checkIfLocationServiesIsEnabled()
                }
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
                    
                    LocationView()
                }
                
                HStack{
                    Spacer()
//                    OutDoorFunctionView(locationModel: locationModel)
//                        .padding(.top,28)
                }
                .padding(.trailing)
                
                Spacer()
            }
            
            Button("View Settings") {
                        showSettings = true
                    }
                    .sheet(isPresented: $showSettings) {
                        AddDangerView()
                            .presentationDetents([.medium, .large])
            }
        }
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
