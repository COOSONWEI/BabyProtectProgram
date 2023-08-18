//
//  OutDoorFunctionsView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/19.
//

import SwiftUI

struct OutDoorFunctionsView: View {
    var body: some View {
        ZStack{
            ZStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(radius: 3)
                HStack{
                    VStack{
                        Text("历史轨迹")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.2)
                            .foregroundColor(.black)
                            .frame(width: 327, alignment: .topLeading)
                        
                    }
                }
            }
            .frame(maxHeight: 132)
            .padding(.leading)
            .padding(.trailing)
            
        }
    }
}

struct OutDoorFunctionsView_Previews: PreviewProvider {
    static var previews: some View {
        OutDoorFunctionsView()
    }
}
