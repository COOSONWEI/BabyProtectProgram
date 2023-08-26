//
//  SuccessView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/24.
//

import SwiftUI

struct SuccessView: View {
    
    var body: some View {
        
        ZStack{
            Image("SuccessBG")
            VStack(spacing:20){
                Image("Success")
                
                //成功时候的设计
                HStack{
                    Button {
                        
                    } label: {
                        Image("backBT")
                    }
                    
                    Button{
                        
                    } label: {
                        ZStack{
                            Rectangle()
                              .foregroundColor(.clear)
                              .frame(maxWidth: 237, maxHeight: 48)
                              .background(Color(red: 1, green: 0.52, blue: 0.49))
                              .cornerRadius(20)
                              .shadow(color: .black.opacity(0.1), radius: 5, x: 4, y: 4)
                              .shadow(color: .black.opacity(0.05), radius: 2, x: 1, y: 1)
                            
                            Text("NEXT LEVEL")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                            .kerning(2.2)
                            .foregroundColor(.white)
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        Image("homeBT")
                    }

                }
                
                Text("点击进入下一关")
                    .font(.system(size: 15))
                    .fontWeight(.medium)
                    .foregroundColor(Color(red: 0.96, green: 0.58, blue: 0.4))
                   
            }
        }
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
    }
}
