//
//  CallPhoneButtonView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/23.
//

import SwiftUI

struct CallPhoneButtonView: View {
    
    var body: some View {
        ZStack{
            Rectangle()
              .foregroundColor(.clear)
             
              .background(Color(red: 0.62, green: 0.62, blue: 0.95))
              .cornerRadius(25)
            
            HStack{
                VStack{
                    Text("孩子安全家长放心\n一键呼叫")
                        .foregroundColor(.white)
                        .lineLimit(nil)
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    
                    //创建拨打电话按钮
                    Button {
                        
                    } label: {
                            
                        Text("点击呼叫宝贝")
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 23)
                    .padding(.vertical, 7)
                    .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                    .cornerRadius(40)

                }
                .padding(.leading)
                
                ZStack{
                    Image("CallBaby")
                    Image("Compass")
                        .offset(x: 60, y: -70)
                }
              
                
            }
        }
        .frame(maxHeight: 140)
       
       
    }
}

struct CallPhoneButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CallPhoneButtonView()
    }
}
