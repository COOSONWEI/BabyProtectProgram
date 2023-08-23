//
//  InDoorDangerousCard.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/13.
//

import SwiftUI

struct InDoorDangerousCard: View {
    
    let name: String
    let subView: String
    
    var body: some View {
        ZStack{
            
            HStack{
                Image("circle.badge.exclamationmark 1")
                
                VStack(alignment:.leading){
                    
                    Text(name)
                        .font(.system(size: 17))
                        .fontWeight(.black)
                        .foregroundColor(.black)
                    
                    Text(subView)
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                    
                }
                
                
                Spacer()
              
            }
            .padding()
            
        }
        .frame(maxWidth: 354, maxHeight: 100)
    }
        
}

struct InDoorDangerousCard_Previews: PreviewProvider {
    static var previews: some View {
        InDoorDangerousCard(name: "厨房区域", subView: "烧伤危险")
    }
}
