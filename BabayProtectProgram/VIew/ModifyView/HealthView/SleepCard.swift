//
//  SleepCard.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/13.
//

import SwiftUI

//MARK: -睡眠质量
struct SleepCard: View {
    //数据
    let sleepTime: Double
    
    var body: some View {
        
        ZStack{
            Rectangle()
              .foregroundColor(.clear)
             
              .background(Color(red: 0.69, green: 0.39, blue: 1))
              .cornerRadius(20)
            
            VStack(alignment:.leading){
                HStack{
                    Text("睡眠数据")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.2)
                      .multilineTextAlignment(.trailing)
                      .foregroundColor(Color(red: 1, green: 0.98, blue: 0.98))
                    
                    Image("Sleep")
                        .resizable()
                        .fixedSize()
                    Spacer()
                }
                
                HStack{
                    
                    Text("卧床时间")
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.2)
                      .multilineTextAlignment(.trailing)
                      .foregroundColor(.white)
                    Spacer()
                    HStack(alignment: .center){
                        Text("\(Int(sleepTime)/60/60)")
                            .font(.system(size: 28))
                            .fontWeight(.bold)
                          .kerning(3)
                          .minimumScaleFactor(0.2)
                          .multilineTextAlignment(.trailing)
                          .foregroundColor(.white)
                          .frame(width: 28, height: 30, alignment: .topTrailing)
                       
                        Text("小时")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.2)
                          .multilineTextAlignment(.trailing)
                          .foregroundColor(.white)
                        
                        Text("\(Int(sleepTime) % 60)")
                            .font(.system(size: 28))
                            .fontWeight(.bold)
                          .kerning(3)
                          .minimumScaleFactor(0.2)
                          .multilineTextAlignment(.trailing)
                          .foregroundColor(.white)
                          .frame(width: 28, height: 30, alignment: .topTrailing)
                        
                        Text("分钟")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.2)
                          .multilineTextAlignment(.trailing)
                          .foregroundColor(.white)
                          
                    }
                    
                }
                
               
                
            }
            .padding()
           
        }
        .frame(maxHeight: 100)
       
    }
}

struct SleepCard_Previews: PreviewProvider {
    static var previews: some View {
        SleepCard(sleepTime: 10.0)
    }
}
