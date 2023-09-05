//
//  NewCustomTabView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/23.
//

import SwiftUI

struct NewCustomTabView: View {
    @StateObject var cloudBeaconModel = CloudBeaconModel()
    var body: some View {
       
            TabView{
                ConectSuccessfulView(cloudBeaconModel: cloudBeaconModel)
                    .tabItem {
                            Image(systemName: "house")
                            Text("首页")
                    }
                    .background(.white)
                
                VStack{
                    GameMainView()
                }
                    .tabItem {

                        Image(systemName: "gamecontroller")
                        Text("游戏")

                    }
                    .background(.white)
                
                VStack{
                    BeaconView(cloudBeaconModel: cloudBeaconModel)
                }
                    .tabItem {
                      
                            Image(systemName: "sensor.tag.radiowaves.forward.fill")
                        
                            Text("守护")
                        
                    }
                    .background(.white)
                
                VStack{
                    ShoppingView()
                }
                    .tabItem {
                       
                            Image(systemName: "bag")
                            Text("商店")
                    }
                    .background(.white)
            }
//            .background(.clear)
//            .accentColor(Color(red: 1, green: 0.67, blue: 0.69))
            .tint(Color(red: 1, green: 0.67, blue: 0.69))
        
           
        //设定颜色
//            .tint(Color(.red))
           
        

    }
}


struct NewCustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        NewCustomTabView()
    }
}
