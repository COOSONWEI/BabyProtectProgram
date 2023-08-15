//
//  HomeBGView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/11.
//

import SwiftUI

struct HomeBGView: View {
    var body: some View {
        ZStack{
            //背景
            VStack{
                ZStack {
                    Image("bg_1")
                        .resizable()
                        .fixedSize()
                    Image("bg_2")
                        .resizable()
                        .scaledToFit()
                        .offset(y: -25)
                }
                Spacer()
            }
            
            //头像（后面会更改为随着设置中进行更换）
            VStack{
                HStack {
                    Image("Avatar")
                    Spacer()
                }
                Spacer()
            }
            .padding(.leading,20)
            .padding(.top,40)

           
            //添加设备
            ZStack{
                VStack{
                    Text("家长监管")
                        .font(.system(size: 21))
                        .kerning(5.25)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("MONITORING")
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .kerning(5.25)
                        .foregroundColor(.white)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(maxWidth: 75, maxHeight: 75)
                            .foregroundColor(.white)
                    }

                    Text("点击添加设备")
                        
                }
               
            }
            
        }
        .frame(maxHeight: 500)
    }
}

struct HomeBGView_Previews: PreviewProvider {
    static var previews: some View {
        HomeBGView()
    }
}
