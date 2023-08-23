//
//  NewCustomTabView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/23.
//

import SwiftUI

struct NewCustomTabView: View {
    var body: some View {
        
   
            TabView{
                ConectSuccessfulView()
                
                    .tabItem {
                        ZStack{
                            Image(systemName: "house")
                            Text("首页")
                        }
                    }
            }
           
        
        
    }
}

struct NewCustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        NewCustomTabView()
    }
}
