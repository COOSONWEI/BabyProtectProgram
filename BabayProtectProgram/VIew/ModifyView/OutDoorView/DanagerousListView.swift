//
//  DanagerousListView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/24.
//

import SwiftUI

struct DanagerousListView: View {
    @Binding var jumptotheLocation: Bool
    var body: some View {
        NavigationView{
            VStack{
                
                HStack{
                    
                    Text("点击下列危险水域，可以跳转到对应的水域\n查看危险区范围")
                    .font(
                    Font.custom("SF Pro Display", size: 15.6)
                    .weight(.semibold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.53, green: 0.53, blue: 0.51))
                    
                }
               
            

                List{
                    DangerousListCard()
                        .onTapGesture {
                            withAnimation {
                                jumptotheLocation = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now()+1){
                                jumptotheLocation = false
                            }
                        }
                }
                .listStyle(.plain)
                .navigationTitle(Text("危险水域"))
            }
           
            
        }
        
       
        
    }
}

struct DanagerousListView_Previews: PreviewProvider {
    static var previews: some View {
        DanagerousListView(jumptotheLocation: .constant(false))
    }
}
