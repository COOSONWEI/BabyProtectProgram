//
//  ChoseView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/25.
//

import SwiftUI

struct ChoseView: View {
    
    var body: some View {
        
        ZStack{
            
            Rectangle()
                .foregroundColor(.clear)
                .background(.white.opacity(0.68))
                .cornerRadius(31.33876)
                .shadow(color: .black.opacity(0.07), radius: 2.5071, x: 5.0142, y: 5.0142)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 110, height: 110)
                .background(.white.opacity(0.8))
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.07), radius: 2.5071, x: 5.0142, y: 5.0142)
            
            HStack{
                
                VStack{
                    Image("Pass_1")
                    Text("游戏冒险")
                }
                
                VStack{
                    Image("Pass_2")
                    Text("知识问答")
                }
                
                VStack{
                    Image("Pass_3")
                    Text("AR互动")
                }
                
            }
        
        }
        .frame(maxHeight: 153)
       
        
        
    }
    
}

struct ChoseView_Previews: PreviewProvider {
    static var previews: some View {
        ChoseView()
    }
}
