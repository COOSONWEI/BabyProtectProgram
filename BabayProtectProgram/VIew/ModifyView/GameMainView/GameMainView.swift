//
//  GameMainView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/25.
//

import SwiftUI

struct GameMainView: View {
    
    var body: some View {
        ZStack{
            
            Image("MainBG")
                .resizable()
                .fixedSize()
            
          ChoseView()
            
        }
    }
}

struct GameMainView_Previews: PreviewProvider {
    static var previews: some View {
        
        GameMainView()
        
    }
    
}
