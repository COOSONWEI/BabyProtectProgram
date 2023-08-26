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
               
                            Image(systemName: "house")
                            Text("首页")
                        
                    }
                
                VStack{
                    GameMainView()
                }
                    .tabItem {
                    
                            Image(systemName: "gamecontroller")
                            Text("游戏")
                    
                    }
                
                VStack{
                    Text("信息")
                }
                    .tabItem {
                      
                            Image(systemName: "message")
                            Text("信息")
                        
                    }
                
                VStack{
                    ShoppingView()
                }
                    .tabItem {
                       
                            Image(systemName: "bag")
                            Text("商店")
                        
                    }
            }
        //设定颜色
//            .tint(Color(.red))
           
        
        
    }
}


struct NewCustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        NewCustomTabView()
    }
}
