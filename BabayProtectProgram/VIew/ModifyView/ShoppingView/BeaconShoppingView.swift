//
//  BeaconShoppingView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/16.
//

import SwiftUI

struct BeaconShoppingView: View {
    var body: some View {
        ZStack{
            Rectangle()
              .foregroundColor(.clear)
            
              .background(.white)
              .cornerRadius(15)
              .shadow(color: .black.opacity(0.1), radius: 6.5, x: 3, y: 3)
              .shadow(color: .black.opacity(0.05), radius: 5, x: 1, y: 1)
            
            VStack(){
                Spacer()
                HStack{
                     Spacer()
                       Image("Beacons")
                        .resizable()
                        .fixedSize()
                        
                }
                    
            }
            
            VStack(alignment: .leading){
                Text("蓝牙信标")
                    .font(.system(size: 7.48755))
                    .foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.12))
                    .minimumScaleFactor(0.2)
                Text("好选择，有效规避对于\n室内危险物品\n存在的隐患")
                    .font(.system(size:  13))
                    .minimumScaleFactor(0.2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Button {
                    
                } label: {
                    Text("点击购买")
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.2)
                        .padding(1)
                }
                .background(.blue)
                .cornerRadius(5)
                .frame(maxWidth: 32, maxHeight: 12)
                Spacer()
            }
            .padding(.top)
           
        }
        .frame(maxWidth: 161, maxHeight: 156)
    }
}

struct BeaconShoppingView_Previews: PreviewProvider {
    static var previews: some View {
        BeaconShoppingView()
    }
}
