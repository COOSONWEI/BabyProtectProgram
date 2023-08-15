//
//  LocationView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/12.
//

import SwiftUI

//添加最近的位置的情况
struct LocationView: View {
    @StateObject var locationModel: LocationModel
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
                
                Text(locationModel.locationName ?? "上海南站")
                    .font(.system(size: 14))
                    .minimumScaleFactor(0.2)
                Text("现在的位置")
                    .font(.system(size: 13))
                    .foregroundColor(.black.opacity(0.4))
                   
                Spacer()
                Button {
                    withAnimation {
                        locationModel.checkLocationAuthorization()
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
        LocationView(locationModel: LocationModel())
    }
}
