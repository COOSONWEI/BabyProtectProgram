//
//  MenuRow.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/9.
//

import SwiftUI

struct MenuRow: View {
    
    let image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .frame(width: 75, height:75)
    }
    
}

struct MenuRow_Previews: PreviewProvider {
    static var previews: some View {
        MenuRow(image: "CallPhone")
    }
}
