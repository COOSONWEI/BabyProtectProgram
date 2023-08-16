//
//  InDoorDangerousCard.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/13.
//

import SwiftUI

struct InDoorDangerousCard: View {
    
    let name: String
    var body: some View {
        ZStack{
            Rectangle()
            .foregroundColor(.clear)
            .background(.white)
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.17), radius: 6.5, x: 3, y: 3)
            .shadow(color: .black.opacity(0.05), radius: 4, x: 1, y: 1)
            
            HStack{
                Text(name)
                    .font(.system(size: 27))
                    .fontWeight(.black)
                    .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                Spacer()
                Image("DangerousLogo")
                    .resizable()
                    .fixedSize()
            }
            .padding()
            
        }
        .frame(maxWidth: 354, maxHeight: 100)
    }
        
}

struct InDoorDangerousCard_Previews: PreviewProvider {
    static var previews: some View {
        InDoorDangerousCard(name: "厨房区域")
    }
}
