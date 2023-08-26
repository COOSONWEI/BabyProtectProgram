//
//  AddPhoneNumber.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/24.
//

import SwiftUI


struct AddPhoneNumber: View {
    
    @Binding var sheetView: Bool
    
    var body: some View {
        
        ZStack{
            
            Button {
                
                withAnimation {
                    sheetView = true
                    print("sheetView = \(sheetView)")
                }
                
            } label: {
                
                HStack{
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFill()
                }
                .padding()
                .background(Circle().foregroundColor(.white))
                .shadow(color: .black.opacity(0.05), radius: 2, x: 4, y: 4)
                .shadow(color: .black.opacity(0.05), radius: 5, x: 1, y: 1)
            }
            .frame(maxWidth: 48, maxHeight: 48)
            
            
            
        }
        
    }
}

struct AddPhoneNumber_Previews: PreviewProvider {
    static var previews: some View {
        AddPhoneNumber(sheetView: .constant(false))
    }
}
