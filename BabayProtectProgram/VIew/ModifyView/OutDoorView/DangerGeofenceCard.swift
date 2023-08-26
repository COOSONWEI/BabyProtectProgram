//
//  DangerGeofenceCard.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/13.
//

import SwiftUI

struct DangerGeofenceCard: View {
    
    let name:String
    let phone: String
    
    var body: some View {
        ZStack{
            HStack{
                VStack(alignment:.leading){
                    HStack{
//                        Text("姓名:")
//                            .font(.system(size: 27))
//                            .fontWeight(.black)
//                            .font(.title)
//                            .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
//
                        Text(name)
                            .font(.system(size: 27))
                            .fontWeight(.black)
                            .font(.title)
                            .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                    }
                    
//                    Text("手机号: \(phone)")
//                        .font(.subheadline)
//                        .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                }
                
                Spacer()
                
            }
            .padding()
            
        }
        .frame(maxWidth: 354, maxHeight: 100)
       
    }
}



struct DangerGeofenceCard_Previews: PreviewProvider {
    static var previews: some View {
        DangerGeofenceCard(name: "爸爸", phone: "19184494122")
    }
}
