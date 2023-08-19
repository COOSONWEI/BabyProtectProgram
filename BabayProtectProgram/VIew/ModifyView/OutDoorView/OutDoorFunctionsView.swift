//
//  OutDoorFunctionsView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/19.
//

import SwiftUI
import MapKit
import CoreLocation

struct OutDoorFunctionsView: View {
    
    @StateObject var mapView: MapViewWrapper
    @StateObject var childLocation: LastLocation
    
    @Binding var walking: Bool
    @Binding var bus: Bool
    @Binding var car: Bool
    
    var body: some View {
        VStack{
            
            //创建交通工具的按钮，选择前往孩子位置的交通路线
            //使用了自定义的按钮样式后高亮反馈默认会被覆盖掉
            HStack{
                Button {

                    print("walking is true")
                    let yourLocation = MKPlacemark(coordinate: mapView.mapVew.userLocation.coordinate)
                    let childLocation = MKPlacemark(coordinate: childLocation.lastCoordinate.center )
                    
                    let youMapItem = MKMapItem(placemark: yourLocation)
                    
                    let childMapItem = MKMapItem(placemark: childLocation)
                    
                    let request = MKDirections.Request()
                    request.source = youMapItem
                    request.destination = childMapItem
                    
                    request.transportType = .walking
                    
                    let directions = MKDirections(request: request)
                    directions.calculate { response, error in
                        if let error = error {
                            print("Error calculating directions: \(error.localizedDescription)")
                            return
                        }
                        
                        guard let route = response?.routes.first else {
                            return
                        }
                        mapView.mapVew.addOverlay(route.polyline)
                        print("add")
                    }
                } label: {
        
                    Image(systemName: "figure.walk")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                }
                //                .buttonStyle(ShadowButtonStyle())
                .frame(maxHeight: 100)
                Spacer()
                Button {
                    car.toggle()
                } label: {
                    Image(systemName: "car")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                }
                .frame(maxHeight: 100)
                Spacer()
                Button {
                    bus.toggle()
                } label: {
                    Image(systemName: "bus")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                }
                .frame(maxHeight: 100)
            }
            .padding(.leading)
            .padding(.trailing)
            
            
            ZStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(radius: 3)
                HStack(alignment:.top){
                    VStack(alignment:.leading){
                        Text("历史轨迹")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.2)
                            .foregroundColor(.black)
                        
                        Text("实时记录宝贝活动轨迹，快去看看吧")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .lineLimit(nil)
                            .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.41))
                            .padding(.top)
                    }
                    .padding(.leading)
                    
                    Image("HistoryPath")
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(maxHeight: 132)
            .padding(.leading)
            .padding(.trailing)
            
            
        }
    }
}

//struct OutDoorFunctionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        OutDoorFunctionsView(walking: .constant(false), bus: .constant(false), car: .constant(false))
//    }
//}
