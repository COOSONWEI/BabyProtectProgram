//
//  ShoppingView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/16.
//

import SwiftUI

struct ShoppingView: View {
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Text("SHOUHU")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                       .multilineTextAlignment(.center)
                       .foregroundColor(Color(red: 0.13, green: 0.19, blue: 0.25))
                      .frame(width: 94, alignment: .top)
                    Spacer()
                }
                .padding(.leading)
            }
            
            WatchShoppingCard()
            HStack{
                WatchCard()
                VStack{
                    BeaconShoppingView()
                    OtherCard_()
                }
            }
            .padding(.bottom)
            Spacer()
        }
    }
}

struct ShoppingView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingView()
    }
}
