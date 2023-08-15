//
//  OutDoorPositionEnterModify.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/11.
//

import SwiftUI

//MARK: -户外检测进入按钮
struct OutDoorPositionEnterModify: View {
    @State var enterOutDoor = false
    var body: some View {
        Button {
            enterOutDoor.toggle()
        } label: {
            ZStack{
                Rectangle()
                  .foregroundColor(.clear)
                  
                  .background(Color(red: 0.31, green: 0.31, blue: 0.31))
                  .cornerRadius(17)
                  .shadow(color: .black.opacity(0.25), radius: 4.5, x: 4, y: 4)
                
                HStack{
                    VStack(alignment: .leading){
                        Text("户外定位")
                            .foregroundColor(.white)
                            .fontWeight(.black)
                        Image("OutDoor")
                            .resizable()
                            .frame(maxWidth: 67, maxHeight: 67)
                            .fixedSize()
                    }
                    Spacer()
                }
                .padding(.leading)
                
                
            }
            .frame(width: 144, height: 144)
        }
        .fullScreenCover(isPresented: $enterOutDoor) {
            OutDoorMainView()
        }

       
    }
}

struct OutDoorPositionEnterModify_Previews: PreviewProvider {
    static var previews: some View {
        OutDoorPositionEnterModify()
    }
}
