//
//  AddInDoorDangerous.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/13.
//

import SwiftUI

struct AddInDoorDangerousView: View {
    
    @State var back = false
    @StateObject var beaconModel = BeaconModel()
    @StateObject var cloudBeaconModel = CloudBeaconModel()
    
    var body: some View {
        
        VStack{
            ZStack {
                VStack{
                    Image("InDoorDangerousBG")
                        .resizable()
                        .edgesIgnoringSafeArea(.top)
                        .fixedSize()
                    Spacer()
                }
                
                VStack{
                    HStack{
                        VStack(alignment:.leading){
                            Text("危险区域")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .minimumScaleFactor(0.2)
                            
                            Text("设置室内危险区域,\n当您的孩子进入这些区域,\n将通知您。")
                                .font(.system(size: 17))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .minimumScaleFactor(0.2)
                                .padding(.top)
                            Spacer()
                        }.padding(.trailing,30)
                        
                        VStack{
                            Image("Danger")
                                .resizable()
                                .frame(maxWidth: 20, maxHeight: 114.29)
                                .fixedSize()
                            Spacer()
                        }
                    }
                }
                VStack{
                    HStack{
                        Button {
                            back.toggle()
                        } label: {
                            Image("dgBackBT")
                                .resizable()
                                .frame(maxWidth: 27, maxHeight: 27)
                                .fixedSize()
                        }
                        Spacer()
                    }
                    .padding(.leading,30)
                    Spacer()
                }
            }
            //添加了危险区的卡片（这里先放一个卡片测试）
            ScrollView{
                ForEach(cloudBeaconModel.usefulBeaconNames.keys.sorted(),id:\.self){ key in
                    InDoorDangerousCard(name: key)
                }
                
            }
            .padding(.top,-150)
           
            AddBeaconButton(cloudModel: cloudBeaconModel)
            
//            DangerButtonView(contacts: <#Contacts#>)
//                .padding(.leading)
//                .padding(.trailing)
//                .padding(.bottom)
            
        }
        .task {
            do{
                try await cloudBeaconModel.fetchBeacons()
                
            }catch{
                print("loading Error")
            }
        }
        .fullScreenCover(isPresented: $back) {
            HomeView()
        }
    }
}

struct AddInDoorDangerousView_Previews: PreviewProvider {
    static var previews: some View {
        AddInDoorDangerousView()
    }
}
