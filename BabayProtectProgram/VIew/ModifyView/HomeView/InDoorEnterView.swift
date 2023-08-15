//
//  InDoorEnterView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/12.
//

import SwiftUI

//MARK: -室内检测
struct InDoorEnterView: View {
    var body: some View {
        Button {
            
        } label: {
            
            ZStack{
                Rectangle()
                  .foregroundColor(.clear)
                  
                  .background(Color(red: 0.31, green: 0.31, blue: 0.31))
                  .cornerRadius(17)
                  .shadow(color: .black.opacity(0.25), radius: 4.5, x: 4, y: 4)
                HStack{
                    VStack(alignment:.leading){
                        Text("室内检测")
                            .foregroundColor(.white)
                            .fontWeight(.black)
                        Image("InDoor")
                            .resizable()
                            .frame(maxWidth: 67, maxHeight: 67)
                            .fixedSize()
                    }
                    Spacer()
                }
                .padding(.leading)
                
            }
            .frame(width: 144, height: 144)
            
        }
    }
}

struct InDoorEnterView_Previews: PreviewProvider {
    static var previews: some View {
        InDoorEnterView()
    }
}
