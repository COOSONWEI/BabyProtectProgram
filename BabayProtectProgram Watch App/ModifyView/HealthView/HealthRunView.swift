//
//  HealthRunView.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/11.
//

import SwiftUI

struct HealthRunView: View {
    
    var distance: Double
    
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
            
            HStack(alignment: .center){
                VStack(alignment:.leading){
                    Text("跑步距离")
                        .font(.system(size: 11.53))
                        .fontWeight(.bold)
                    Text("\( String(format: "%.2f", distance))公里")
                        .font(.system(size: 13.05))
                        .fontWeight(.bold)
                    
                    Text("Today")
                        .font(.system(size: 7.7))
                        .foregroundColor(Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 0.5))
                }
                .padding(.leading,5)
                Spacer()
            }
            
        }
        .frame(maxWidth: 85.9037, maxHeight: 48.51033)
    }
}

struct HealthRunView_Previews: PreviewProvider {
    static var previews: some View {
        HealthRunView(distance: 100.0)
    }
}
