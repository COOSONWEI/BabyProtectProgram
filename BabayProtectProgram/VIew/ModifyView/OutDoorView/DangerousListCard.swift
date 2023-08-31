//
//  DangerousListCard.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/24.
//

import SwiftUI

struct DangerousListCard: View {
    
    let image: String
    let street: String
//    "DangerousAreaTest"
    var body: some View {
        HStack{
            Image(image)
                .resizable()
                .scaledToFit()
//            street
//            "中国上海市浦东新区陆家嘴陆家嘴环路717号"
            VStack{
                Text("水域危险区")
                    .font(.system(size: 16))
                Text(street)
                    .font(.subheadline)
            }
        }
    }
}

struct DangerousListCard_Previews: PreviewProvider {
    
    static var previews: some View {
        DangerousListCard(image: "DangerousAreaTest", street: "中国上海市浦东新区陆家嘴陆家嘴环路717号")
    }
    
}
