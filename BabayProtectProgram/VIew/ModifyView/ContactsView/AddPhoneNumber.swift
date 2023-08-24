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
                }
                
            } label: {
                
                HStack{
                    Image("circle.badge.plus 2")
                        .resizable()
                        .frame(maxWidth: 33, maxHeight: 30)
                    
                    VStack(alignment:.leading){
                        
                        Text("添加联系人")
                            .font(Font.custom("SF Pro Display", size: 17))
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                        
                        Text("点击添加新的联系人")
                            .font(Font.custom("SF Pro Display", size: 15))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.53, green: 0.53, blue: 0.51))
                        
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
                .padding()
                .frame(maxWidth: 343)
                .background(.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.05), radius: 2, x: 4, y: 4)
                .shadow(color: .black.opacity(0.05), radius: 5, x: 1, y: 1)
            }
            
            
            
        }
        
    }
}

struct AddPhoneNumber_Previews: PreviewProvider {
    static var previews: some View {
        AddPhoneNumber(sheetView: .constant(false))
    }
}
