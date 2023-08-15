//
//  DangerButtonView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/13.
//

import SwiftUI

//MARK: -添加危险区按钮
struct DangerButtonView: View {
    var body: some View {
        Button {
            
        } label: {
            ZStack{
                Rectangle()
                .cornerRadius(15)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.17), radius: 6.5, x: 3, y: 3)
                .shadow(color: .black.opacity(0.05), radius: 4, x: 1, y: 1)
                HStack{
                    LinearColorText(text: "危险区域添加", colors: [Color(red: 255/255, green: 131/255, blue: 149/255),
                                                             Color(red: 255/255, green: 131/255, blue: 149/255)
                                                                       ])
                    Spacer()
                    Image("AddBT")
                        .resizable()
                        .frame(maxWidth: 31.26496, maxHeight: 31)
                        .fixedSize()
                }
                .padding()
             
                }
            }
        .padding(.leading)
        .padding(.trailing)
        .frame(maxHeight: 64)
        }
    
    
    }

struct LinearColorText: View {
    let text: String
    let colors: [Color]
    var body: some View {
        HStack{
            Text(text)
                .font(.system(size: 20))
                .minimumScaleFactor(0.2)
                .kerning(1)
                .foregroundColor(.clear)
                            .background(LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing))
                            .mask( Text(text).font(.system(size: 20))
                                .foregroundColor(.white))
                    }
    }
}


struct DangerButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DangerButtonView()
    }
}
