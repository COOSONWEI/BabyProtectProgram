//
//  WatchCard.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/16.
//

import SwiftUI

struct WatchCard: View {
    var body: some View {
        ZStack{
           Rectangle()
            .foregroundColor(.white)
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.07), radius: 7, x: 5, y: 8)
            .shadow(color: .black.opacity(0.08), radius: 5.5, x: 1, y: 1)
            
            VStack(alignment:.leading){
                Text("Apple Watch Studio")
                    .font(.system(size: 7.48755))
                    .foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.12))
                    .minimumScaleFactor(0.2)
                Text("选择Apple Watch\n能更好守护\n孩子安全")
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
                   Image("Watchs")
                    .resizable()
                    .fixedSize()
                    
            }
            .padding(.top)
            .padding(.leading)
            
        }
        .frame(maxWidth: 171, maxHeight: 261)
        
    }
}

struct WatchCard_Previews: PreviewProvider {
    static var previews: some View {
        WatchCard()
    }
}
