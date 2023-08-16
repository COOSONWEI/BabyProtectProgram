//
//  ShoppingCard.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/16.
//

import SwiftUI

struct WatchShoppingCard: View {
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Image("WatchLogo")
                    .padding(.trailing,40)
            }
           
            ZStack{
                Rectangle()
                  .foregroundColor(.clear)
                  
                  .background(.white)
                  .cornerRadius(15)
                  .shadow(color: .black.opacity(0.08), radius: 6, x: 4, y: 4)
                  .shadow(color: .black.opacity(0.04), radius: 3, x: 2, y: 2)
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(maxWidth: 285.35626, maxHeight: 94.60927)
                  .background(
                    Image("Apple-Watch")
                      .resizable()
                      .aspectRatio(contentMode: .fill)
                      .frame(maxWidth: 285.35626220703125, maxHeight: 94.60926818847656)
                      .clipped()
                  )
            }
            .frame(maxHeight: 104)
            .padding(.leading)
            .padding(.trailing)
        }
       
    }
}

struct WatchShoppingCard_Previews: PreviewProvider {
    static var previews: some View {
        WatchShoppingCard()
    }
}
