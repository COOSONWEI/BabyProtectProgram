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

    @State var locationName = ""
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
                
                Text(locationName != "" ? locationName : "您孩子现在的位置")
                    .font(.system(size: 13))
                    .foregroundColor(.black.opacity(locationName != "" ? 1 : 0.4))
                    
                Spacer()
                Button {
                    withAnimation {
//                        locationModel.checkLocationAuthorization()
                        let geocoder = CLGeocoder()
                        let location = CLLocation(latitude: locationModel.lastCoordinate.center.latitude, longitude: locationModel.lastCoordinate.center.longitude)
                        print("location === \(location)")
                        geocoder.reverseGeocodeLocation(location) { placemarks, error in
                            if let error = error {
                                   print("Error calculating directions: \(error.localizedDescription)")
                                locationName = "Location Not Found"
                                   return
                               }
                            if let placemark = placemarks?.first {
                                print("placemark: \(placemark)")
                                if let street = placemark.thoroughfare, let city = placemark.locality {
                                    print("lalalalllnihaoya")
                                    self.locationName = "\(street), \(city)"
                                    print("locationNames\(street),\(city)")
                                } else {
                                    self.locationName = "\(placemark)"
                                }
                                self.locationName = getLocationStreetName(inputString: self.locationName)
                            }
                        }

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
    
    func getLocationStreetName(inputString: String) -> String {
        let components = inputString.components(separatedBy: " @ ")

        if components.count >= 2 {
            let address = components[0]
            print("Address: \(address)")
            return address
        } else {
            print("Invalid input string format")
        }
        return "Not Found Text"
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(locationModel: LastLocation(), locationCloudStroe: LocationCloudStroe())
    }
}
