//
//  HealthRestingheartRateView.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/11.
//

import SwiftUI

struct HealthRestingheartRateView: View {
    var rate: Int
    var body: some View {
        ZStack{
            Rectangle()
            .foregroundColor(.clear)
            
            .background(Color(red: 0.8, green: 0.8, blue: 0.8).opacity(0.14))
            .cornerRadius(2.52658)
            
            VStack(alignment: .leading){
                Text("静息心率")
                    .font(.system(size: 8))
                HStack(alignment: .center){
                
                    HStack(alignment: .bottom,spacing: 0){
                        Text("\(rate)")
                        .font(.system(size: 15.16))
                      
                        Text("BPM")
                        .font(.system(size: 11.62))
                        .foregroundColor(.red)
                    }
                    Spacer()
                    
                }
                
            }
            .padding(.leading,5)
        }
        .frame(maxWidth: 85.9037, maxHeight: 42.95185)
    }
}

struct HealthRestingheartRateView_Previews: PreviewProvider {
    static var previews: some View {
        HealthRestingheartRateView(rate: 56)
    }
}
