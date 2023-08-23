//
//  FIrstEnterView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/22.
//

import SwiftUI

struct FIrstEnterView: View {
    @State var enterTheHomeView = false
    var body: some View {
        ZStack{
            Image("EnterBG")
                .ignoresSafeArea()
            
            VStack(alignment:.center) {
                Image("EnterLogo")
                
                
                Text("守护")
                    .font(.custom("SF Pro", size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.14, green: 0.15, blue: 0.18))
                    .foregroundColor(Color(red: 0.14, green: 0.15, blue: 0.18))
                
                Text("PROTECTION")
                    .font(.custom("SF Pro", size: 25))
                  .kerning(3.75)
                  .foregroundColor(Color(red: 0.14, green: 0.15, blue: 0.18))
                
                
                
                Button {
                    
                } label: {
                    
                        Text("ENTER")
                            .font(.custom("SF Pro", size: 20))
                            .fontWeight(.bold)
                          .kerning(1.2)
                          .multilineTextAlignment(.center)
                          .foregroundColor(.white)
                    
                }
                .background(
                    Capsule()
                    .padding(.horizontal, 52)
                    .padding(.vertical, 16)
                    .frame(width: 276, height: 55, alignment: .center)
                    .background(Color(red: 0.1, green: 0.11, blue: 0.2))
                    .cornerRadius(40)
                    .shadow(color: Color(red: 0.1, green: 0.11, blue: 0.2).opacity(0.1), radius: 15, x: 0, y: 20)
                    
                )
                .padding(.top,60)
              
                
                
            }
        }
    }
}

struct FIrstEnterView_Previews: PreviewProvider {
    static var previews: some View {
        FIrstEnterView()
    }
}
