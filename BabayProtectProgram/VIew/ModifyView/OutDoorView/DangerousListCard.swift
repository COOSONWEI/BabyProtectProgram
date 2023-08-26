//
//  DangerousListCard.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/24.
//

import SwiftUI

struct DangerousListCard: View {
    var body: some View {
        HStack{
            Image("DangerousAreaTest")
                .resizable()
                .scaledToFit()
            
            VStack{
                Text("水域危险区")
                    .font(.system(size: 16))
                Text("中国上海市浦东新区陆家嘴陆家嘴环路717号")
                    .font(.subheadline)
            }
        }
    }
}

struct DangerousListCard_Previews: PreviewProvider {
    static var previews: some View {
        DangerousListCard()
    }
}
