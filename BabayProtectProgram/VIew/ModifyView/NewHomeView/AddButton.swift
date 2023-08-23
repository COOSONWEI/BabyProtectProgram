//
//  SwiftUIView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/23.
//

import SwiftUI

struct AddButton: View {
    
    let name: String
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 339, height: 73)
                .background(.white)
                .cornerRadius(17)
                .shadow(color: .black.opacity(0.05), radius: 4.5, x: 1, y: 1)
//                .shadow(color: .black.opacity(0.05), radius: 4, x: 3, y: 3)
            
            Text("\(name)")
                .font(.system(size: 20))
                .fontWeight(.black)
                .kerning(1)
                .foregroundColor(Color(red: 0.31, green: 0.31, blue: 0.31))
                .frame(width: 297.71469, alignment: .topLeading)
            
        }
    }
}
