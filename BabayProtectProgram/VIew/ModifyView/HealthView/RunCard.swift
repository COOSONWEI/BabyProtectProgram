//
//  RunCard.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/13.
//

import SwiftUI

//MARK: -跑步记录

struct RunCard: View {
    //数据
    let distance: Double
    
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
                
                Text("详细记录")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 103, height: 30, alignment: .topLeading)
                    .minimumScaleFactor(0.2)
                
                HStack {
                    VStack{
                        Text("跑步")
                            .font(.system(size: 23))
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.2)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Color(red: 1, green: 0.82, blue: 0.59))
                        HStack{
                            Text("\(String(format: "%.2f", distance))")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .minimumScaleFactor(0.2)
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(Color(red: 1, green: 0.82, blue: 0.59))
                            
                            Text("公里")
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                                .minimumScaleFactor(0.2)
                                .foregroundColor(Color(red: 1, green: 0.82, blue: 0.59))
                        }
                      
                    }
                    
                    Image("Run")
                        .resizable()
                        .frame(maxWidth: 58, maxHeight: 63)
                        .fixedSize()
                }
                
                
               
            }
            
            
        }
        .frame(maxWidth: 136, maxHeight: 136)
    }
}

struct RunCard_Previews: PreviewProvider {
    static var previews: some View {
        RunCard(distance: 0)
    }
}
