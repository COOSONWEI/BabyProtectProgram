//
//  EnterUUID.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/13.
//

import SwiftUI

struct EnterUUID: View {
    
    @AppStorage ("UUID") var uuid = "UUID"
    
    var body: some View {
        VStack{
           TextField("请输入信标的UUID", text: $uuid)
            TextField("请输入信标的UUID", text: $uuid)
        }
    }
}

struct EnterUUID_Previews: PreviewProvider {
    static var previews: some View {
        EnterUUID()
    }
}
