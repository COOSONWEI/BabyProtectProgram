//
//  BeaconCardVIew.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/29.
//

import SwiftUI

struct BeaconCardView: View {
    
    let name: String
    let uuid: String
    
    var body: some View {
        
            ZStack{
                Rectangle()
                  .foregroundColor(.clear)
                 
                  .background(.white)
                  .cornerRadius(15)
                  .shadow(color: Color(red: 0.85, green: 0.85, blue: 0.85).opacity(0.2), radius: 5, x: 0, y: 4)
                
                HStack{
                    VStack(alignment: .leading){
                        Text(name)
                          .font(
                            Font.custom("PingFang SC", size: 16)
                              .weight(.medium)
                          )
                          .multilineTextAlignment(.center)
                          .foregroundColor(Color(red: 0.05, green: 0.05, blue: 0.05))
                        
                        Text("UUID: \(uuid)")
                          .font(Font.custom("PingFang SC", size: 12))
                          .multilineTextAlignment(.center)
                          .foregroundColor(Color(red: 0.64, green: 0.64, blue: 0.64))
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 5, height: 10.5)
                        .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
                }
                .padding(.leading)
                .padding(.trailing)
                
            }
            .frame(width: 364, height: 86)
        
       
    }
}

struct BeaconCardView_Previews: PreviewProvider {
    static var previews: some View {
        BeaconCardView(name: "厨房", uuid: "sadifhshfosaf")
    }
}
