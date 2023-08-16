//
//  OtherCard .swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/16.
//

import SwiftUI

struct OtherCard_: View {
    var body: some View {
        ZStack{
            Rectangle()
              .foregroundColor(.clear)
             
              .background(.white)
              .cornerRadius(15)
              .shadow(color: .black.opacity(0.1), radius: 8, x: 5, y: 4)
              .shadow(color: .black.opacity(0.05), radius: 7.5, x: 1, y: 1)
            
            VStack{
                HStack{
                    Text("敬请期待...")
                      .font(.system(size: 13))
                      .fontWeight(.bold)
                      .minimumScaleFactor(0.2)
                    Spacer()
                }
                .padding()
                Spacer()
            }
              
        }
        .frame(maxWidth: 161, maxHeight: 87)
       
    }
}

struct OtherCard__Previews: PreviewProvider {
    static var previews: some View {
        OtherCard_()
    }
}
