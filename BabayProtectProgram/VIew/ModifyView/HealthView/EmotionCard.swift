//
//  EmotionCard.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/13.
//

import SwiftUI

//MARK: -宝贝心情
struct EmotionCard: View {
    var body: some View {
        VStack {
            HStack{
                VStack(alignment:.leading){
                    HStack{
                        Text("宝贝心情")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.2)
                          .multilineTextAlignment(.trailing)
                          .foregroundColor(.black)
                        
                        Image("Emotion")
                            .resizable()
                            .fixedSize()
                    }
                    Text("宝贝现在很开心！")
                      
                        .font(.system(size: 15))
                        .minimumScaleFactor(0.2)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.black)
                }
                Spacer()
               Image("Happy")
                    .resizable()
                    .fixedSize()
            }
            Divider()
        }
    }
}

struct EmotionCard_Previews: PreviewProvider {
    static var previews: some View {
        EmotionCard()
    }
}
