//
//  WarningView.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/9.
//

import SwiftUI

struct WarningView: View {
    let dangerousType: DangerousType
    let phone: String
    var body: some View {
        //这里分为程序运行中和后台运行的两个通知方式
        VStack {
            Text(dangerousType == .beacon ? "请勿触碰危险物品!" : "请勿接近危险区")
                .multilineTextAlignment(.center)
            Image(dangerousType == .beacon ? "Endanger" : "Danger")
                .resizable()
                .scaledToFit()
            Text("打电话给爸爸妈妈")
            Spacer()
            Button {
                //这里后面要重新设计
                callContact(phone)
            } label: {
                ZStack{
                    Rectangle().fill(Color(red: 66/255, green: 92/255, blue: 247/255))
                        .frame(maxHeight: 54)
                        .cornerRadius(8.18)
                    Image(systemName: "phone")
                        .resizable()
                        .scaleEffect(0.2)
                }
            }
            .buttonStyle(CustomButtonStyle())
            .edgesIgnoringSafeArea(.bottom)
        }
       
       
    }
}

struct WarningView_Previews: PreviewProvider {
    static var previews: some View {
        WarningView(dangerousType: .geofencation, phone: "1")
    }
}
