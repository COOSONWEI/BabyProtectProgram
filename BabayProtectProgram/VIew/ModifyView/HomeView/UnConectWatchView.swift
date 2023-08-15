//
//  UnConectWatchView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/11.
//

import SwiftUI

struct UnConectWatchView: View {
    
    @State private var isWatchPaired = false
    @StateObject var watchModel = ViewModelPhone()
    
    var body: some View {
        
        ZStack{
            //背景
           
            VStack{
                ZStack{
                    Image("bg_1")
                        .resizable()
                        .fixedSize()
                    
                    Image("bg_2")
                        .resizable()
                        .scaledToFit()
                        .offset(y: -10)
                }
                .ignoresSafeArea(.all)
                Spacer()
            }
            
            VStack{
                HStack{
                    Image("Avatar")
                        .resizable()
                        .frame(maxWidth: 50.54, maxHeight: 57.22)
                        .fixedSize()
                        .padding(.leading)
                    Spacer()
                }
                
                Text("家长监督")
                    .font(.system(size: 21))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.5)
                
                Text("MONITORING")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.5)
                
                Text("孩子安全家长放心")
                    .font(.system(size: 13))
                    .minimumScaleFactor(0.5)
                    .kerning(21.71)
                    .foregroundColor(.white)
                    .opacity(isWatchPaired ? 1 : 0)
                
                Button {
                    openWatchAppSettings()
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(maxWidth: 65, maxHeight: 65)
                        .foregroundColor(.white)
                }
                
                
                Text("点击添加手表")
                    .font(.system(size: 15))
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.white)
                
                Text("AppleWatch\n进行同步")
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 300)
                    .font(.custom("Montserrat", fixedSize: 39))
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.5)
                    .padding(.top,20)
                
                Text("请先将Apple Watch进行同步，否则将无法使用该区域功能，点击上方加号添加设备。")
                    .font(.custom("Montserrat", fixedSize: 18))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 285)
                    .minimumScaleFactor(0.5)
                    .padding(.top,6)
                
                Image("Watch")
                    .resizable()
                    .fixedSize()
                    .padding(.top)
                
                Spacer()
                
            }
            
        }
        .onAppear {
            // 检测匹配状态并更新变量
            
        }
    }
    
    func openWatchAppSettings() {
        guard let watchAppURL = URL(string: "x-apple-watch://") else {
            return
        }
        
        UIApplication.shared.open(watchAppURL, options: [:]) { success in
            if !success {
                print("无法打开 Watch 应用设置")
            }
        }
    }
}

struct UnConectWatchView_Previews: PreviewProvider {
    static var previews: some View {
        UnConectWatchView()
    }
}
