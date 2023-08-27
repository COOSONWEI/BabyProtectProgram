//
//  BeaconStateView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/27.
//

import SwiftUI

struct BeaconStateView: View {
    
    @Binding var isNear: Bool
    let name: String
    
    var body: some View {
        
        ZStack{
            Rectangle()
                .foregroundColor(.clear)
                .background(.white)
                .cornerRadius(15)
                .shadow(color: Color(red: 0.76, green: 0.76, blue: 0.76).opacity(0.2), radius: 10, x: 0, y: 4)
            VStack(alignment:.leading){
                
                //通过一个状态来控制颜色的变化
                HStack(alignment:.center){
                    
                    Image("BeaconiCon")
                    Spacer()
                    Image(isNear ? "Near" : "Far")
                    
                }
                //传入信标名称和电量
                Text("\(name)信标")
                  .font(
                    Font.custom("PingFang SC", size: 13)
                      .weight(.medium)
                  )
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.05, green: 0.05, blue: 0.05))
                Text("连接正常｜电量98%")
                    .font(Font.custom("PingFang SC", size: 12))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.64, green: 0.64, blue: 0.64))
            }
            .padding()
           
        }
        .frame(maxWidth: 180, maxHeight: 115)
       
    }
}

struct BeaconStateView_Previews: PreviewProvider {
    static var previews: some View {
        BeaconStateView(isNear: .constant(false), name: "厨房")
    }
}
