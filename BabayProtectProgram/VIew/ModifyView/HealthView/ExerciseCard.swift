//
//  ExerciseCard.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/13.
//

import SwiftUI

//MARK: -运动记录
struct ExerciseCard: View {
    //数据
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.clear)
                .background(Color(red: 0.31, green: 0.31, blue: 0.31))
                .background(
                    EllipticalGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.88, green: 0, blue: 1), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.88, green: 0, blue: 1).opacity(0), location: 1.00),
                        ],
                        center: UnitPoint(x: 0.65, y: 0.17)
                    )
                )
            
                .background(
                    EllipticalGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0, green: 0.83, blue: 1), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.25, green: 0.83, blue: 0.95).opacity(0), location: 1.00),
                        ],
                        center: UnitPoint(x: 0.17, y: 0.91)
                    )
                )
                .cornerRadius(20)
                .shadow(color: Color(red: 0.35, green: 0.35, blue: 0.97).opacity(0.2), radius: 24.5, x: 0, y: 9)
            VStack(alignment:.leading){
                Text("运动记录")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.2)
                    .foregroundColor(Color(red: 1, green: 0.82, blue: 0.59))
                    .frame(width: 130, height: 37, alignment: .topLeading)
                
                VStack(alignment: .leading){
                    HStack{
                        Text("\(0)")
                            .font(.system(size: 30))
                            .minimumScaleFactor(0.2)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.white)
                        Text("分钟")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.2)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.white)
                        
                    }
                    Text("累计0天，连续0天")
                        .font(Font.custom("DM Sans", size: 15))
                        .foregroundColor(.white.opacity(0.77))
                }
                
                HStack{
                    VStack(alignment: .leading){
                        
                        Text("今日运动时长")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                            .minimumScaleFactor(0.2)
                            .frame(width: 90, height: 33.42857, alignment: .topLeading)
                        
                        HStack{
                            Text("\(0)")
                                .font(.system(size: 30))
                                .minimumScaleFactor(0.2)
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(.white)
                            Text("分钟")
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                                .minimumScaleFactor(0.2)
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(.white)
                            
                        }
                        
                    }
                    
                    VStack(alignment: .leading){
                        
                        Text("今日消耗")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                            .minimumScaleFactor(0.2)
                            .frame(width: 90, height: 33.42857, alignment: .topLeading)
                        
                        HStack{
                            Text("\(0)")
                                .font(.system(size: 30))
                                .minimumScaleFactor(0.2)
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(.white)
                            Text("千卡")
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                                .minimumScaleFactor(0.2)
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(.white)
                            
                        }
                        
                    }
                }
                .padding(.top,30)
               
                
                
                
                
            }
            .padding(.leading)
        }
        .frame(maxWidth: 209, maxHeight: 279)
    }
    
}

struct ExerciseCard_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseCard()
    }
}
