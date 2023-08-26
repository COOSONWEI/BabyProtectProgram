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
        HStack{
            
            Image(name == "添加室内信标" ? "sensor.tag.radiowaves.forward 3" : "person.fill.badge 3")
            
            Text("\(name)")
                .font(.system(size: 18.01363))
                .fontWeight(.bold)
                .kerning(0.90068)
                .foregroundColor(Color(red: 0.31, green: 0.31, blue: 0.31))
//                .frame(maxWidth: 297.94019, alignment: .topLeading)
            
            Spacer()
            
            Image(systemName: "plus")
                .resizable()
                .fixedSize()
                .padding()
                .background(Circle().foregroundColor(.white)
                    .frame(maxWidth: 26, maxHeight: 26)
                    )
                .shadow(color: .black.opacity(0.05), radius: 2, x: 4, y: 4)
                .shadow(color: .black.opacity(0.05), radius: 5, x: 1, y: 1)

            
        }
    }
}
