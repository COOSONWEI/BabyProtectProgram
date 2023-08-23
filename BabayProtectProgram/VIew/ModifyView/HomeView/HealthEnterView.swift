//
//  HealthEnterView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/12.
//

import SwiftUI

//MARK: -健康检测进入界面
struct HealthEnterView: View {
    
    @State var enterHealthDtect = false
   
    
    var body: some View {
       
        
            ZStack{
                Rectangle()
                  .foregroundColor(.clear)
                 
                  .background(Color(red: 1, green: 0.53, blue: 0.59))
                  .cornerRadius(17)
                  .shadow(color: .black.opacity(0.05), radius: 3, x: 6, y: 6)
                  .shadow(color: .black.opacity(0.1), radius: 5.5, x: 1, y: 1)
                HStack{
                    VStack(alignment:.leading){
                        Text("健康检测")
                            .foregroundColor(.white)
                            .fontWeight(.black)
                        Image("Health")
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

struct HealthEnterView_Previews: PreviewProvider {
    static var previews: some View {
        HealthEnterView()
    }
}
