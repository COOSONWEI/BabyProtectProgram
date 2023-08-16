//
//  OutDoorFunctionView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/12.
//

import SwiftUI

//MARK: -地图的按钮功能
struct OutDoorFunctionView: View {
//    var locationModel: LocationModel
    
    var body: some View {
        ZStack{
            Capsule()
                .foregroundColor(.white)
                .shadow(radius: 5)
            
            VStack{
                Button {
                    
                } label: {
                    Image("Hear")
                        .resizable()
                        .frame(maxWidth: 32, maxHeight: 32)
                        .fixedSize()
                }

                Text("听音")
                    .font(.system(size: 9))
                    .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                    .minimumScaleFactor(0.2)
                  
                Divider()
                
                Button {
                    
                    //添加动画让移动更加的丝滑
                    withAnimation {
//                        locationModel.checkLocationAuthorization()
                    }
                   
                } label: {
                    Image("location")
                        .resizable()
                        .frame(maxWidth: 32, maxHeight: 32)
                        .fixedSize()
                    
                }
                
                Text("定位")
                    .font(.system(size: 9))
                    .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                    .minimumScaleFactor(0.2)

                Divider()
                
                Image("battery")
                    .resizable()
                    .frame(maxWidth: 32, maxHeight: 32)
                    .fixedSize()
                
                Text("90%")
                    .font(.system(size: 9))
                    .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                    .minimumScaleFactor(0.2)
                
                
            }
        }
        .frame(maxWidth: 40, maxHeight: 193)
       
    }
}

struct OutDoorFunctionView_Previews: PreviewProvider {
    static var previews: some View {
        OutDoorFunctionView()
    }
}
