//
//  MoreInformationList.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/13.
//

import SwiftUI

//MARK: -更多健康信息
struct MoreInformationList: View {
    var body: some View {
        ZStack{
            Rectangle()
              .foregroundColor(.clear)
              .background(Color(red: 1, green: 1, blue: 1))
              .cornerRadius(20)
              .shadow(color: .black.opacity(0.08), radius: 4, x: -1, y: -1)
              .shadow(color: .black.opacity(0.09), radius: 5, x: 4, y: 5)
            
            ScrollView{
               HeartRateCard()
               EmotionCard()
            }
            .padding()
         
        }
        
    }
}

struct MoreInformationList_Previews: PreviewProvider {
    static var previews: some View {
        MoreInformationList()
    }
}
