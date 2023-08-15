//
//  SleepView.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/11.
//

import SwiftUI

struct SleepView: View {
    //MARK: -数据变量
    let sleepTime: TimeInterval
    
    var body: some View {
        ZStack{
            Rectangle()
              .foregroundColor(.clear)
              .background(
                LinearGradient(
                  stops: [
                    Gradient.Stop(color: Color(red: 1, green: 0.4, blue: 0.41), location: 0.00),
                    Gradient.Stop(color: Color(red: 1, green: 0.53, blue: 0.68), location: 1.00),
                  ],
                  startPoint: UnitPoint(x: 0.5, y: 0),
                  endPoint: UnitPoint(x: 0.5, y: 1)
                )
              )
              .cornerRadius(2.52658)
              .shadow(color: .black.opacity(0.34), radius: 2.27392, x: 0, y: 2.02126)
            
            VStack(alignment: .leading){
                HStack(alignment: .bottom){
                    Text("睡眠检测")
                        .font(
                            .system(size: 13.04726)
                        )
                        .kerning(0.91331)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Image(systemName: "moon.zzz.fill")
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.leading,10)
                
                HStack{
                    Text("Today")
                        .font(.system(size: 10.10632))
                       
                      .foregroundColor(.white.opacity(0.5))
                      .frame(width: 52.04754, height: 8.59037, alignment: .topLeading)
                      .padding(.leading,10)
                    
                    Spacer()
                    
                    Text("\(Int(sleepTime)/60/60)小时\(Int(sleepTime) % 60)分钟")
                        .font(.system(size: 10.52068))
                      .fontWeight(.bold)
                      .kerning(0.31562)
                      .foregroundColor(.white)
                      .padding(.trailing,5)
                }
               
            }
        }
        .frame(maxWidth:174.33,maxHeight: 48.51)
    }
}

struct SleepView_Previews: PreviewProvider {
    static var previews: some View {
        SleepView(sleepTime: 0.0)
    }
}
