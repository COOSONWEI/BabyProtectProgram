//
//  LocationView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/12.
//

import SwiftUI
import CoreLocation

//添加最近的位置的情况
struct LocationView: View {
    @StateObject var locationModel: LastLocation
    
    @State private var locationName = ""
    @StateObject var locationCloudStroe: LocationCloudStroe
    
    var body: some View {
        ZStack{
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 319, height: 49)
              .background(Color(red: 0.98, green: 0.91, blue: 0.76))
              .cornerRadius(20)
              .offset(y: 3)
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 327, height: 43.93103)
              .background(.white)
              .cornerRadius(20)
            
            HStack(alignment:.center){
                
                Image("landmark")
                    .frame(maxWidth: 24, maxHeight: 24)
                //获取实例显示街区信息
                Text("\(locationName)")
                    .font(.system(size: 14))
                    .minimumScaleFactor(0.2)
                Text("孩子现在的位置")
                    .font(.system(size: 13))
                    .foregroundColor(.black.opacity(0.4))
                Spacer()
                Button {
                    withAnimation {
//                        locationModel.checkLocationAuthorization()
                        let geocoder = CLGeocoder()
                        let location = CLLocation(latitude: locationModel.location.latitude, longitude: locationModel.location.longitude)
                        let parts = locationCloudStroe.streeName.components(separatedBy: " @ ")
                        if let firstPart = parts.first {
                            self.locationName = firstPart
                        }
                       
                        print("self.locationName\(self.locationName)")
//                        geocoder.reverseGeocodeLocation(location) { placemarks, error in
//                            if let placemark = placemarks?.first {
//                                if let street = placemark.thoroughfare, let city = placemark.locality {
//                                    self.locationName = "\(street), \(city)"
//                                    print("locationName\(street),\(city)")
//                                } else {
//                                    self.locationName = "Location Not Found"
//                                }
//                            } else {
//                                self.locationName = "Location Not Found"
//                            }
//                        }
                    }
                } label: {
                    Text("刷新")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.2)
                        .foregroundColor(Color(red: 1, green: 0.48, blue: 0.16))
                }
            }
            .padding()
        }
        .frame(maxWidth: 327, maxHeight: 50)
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(locationModel: LastLocation(), locationCloudStroe: LocationCloudStroe())
    }
}
