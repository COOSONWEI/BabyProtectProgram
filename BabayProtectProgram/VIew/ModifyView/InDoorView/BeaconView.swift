//
//  BeaconView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/27.
//

import SwiftUI
import Lottie

struct BeaconView: View {
    @StateObject var cloudBeaconModel = CloudBeaconModel()
    
    @State private var showLoadingIndicator = false
    
    @State private var networkFalse = false
    
    var body: some View {
        ZStack{
            VStack{
                
                //设置按钮
                HStack(spacing:15){
                    Text("守护设备")
                        .font(.custom("PingFang SC", size: 28))
                        .fontWeight(.medium)
                        .kerning(1.4)
                        .foregroundColor(Color(red: 0.32, green: 0.32, blue: 0.32))
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "bell")
                            .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.09))
                            
                    }
                    .frame(width: 28, height: 29)

                   
                    Button {
                        
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.09))
                    }
                    .frame(width: 29, height: 29)
                    
                }
                
                
                //获取实时动态
                ZStack{
                    
                    Rectangle()
                        .foregroundColor(.clear)
                    
                        .background(.white)
                        .cornerRadius(15)
                        .shadow(color: Color(red: 0.76, green: 0.76, blue: 0.76).opacity(0.2), radius: 10, x: 0, y: 4)
                    
                    VStack{
                        
                        HStack{
                            Text("实时状态")
                            Spacer()
                        }
                        .padding(.leading)
                        .padding(.top)
                        
                        Spacer()
                    }
                    
                    VStack{
                        //放置动画
                        Image(systemName: "light.beacon.max")
                            .resizable()
                            .frame(maxWidth: 96, maxHeight: 73)
                            .foregroundColor(.red)
                        
                        //触发的信标名称，时间(预留一个量去改变它的位置)
                        Text("孩子正在靠近厨房危险区")
                            .font(.custom("PingFang SC", size: 13))
                            .fontWeight(.medium)
                            .foregroundColor(Color(red: 0.05, green: 0.05, blue: 0.05))
                        
                        Text("2023.9.1 9:41 信标被触发")
                            .multilineTextAlignment(.center)
                            .font(.custom("PingFang SC", size: 12))
                            .foregroundColor(Color(red: 0.64, green: 0.64, blue: 0.64))
                    }
                    
                }
                .frame(maxHeight: 268)
                
                ScrollView(.vertical,showsIndicators: false){
                    
                    //加载已添加的信标和它的状态
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16)
                    ], spacing: 16) {
                        
                        ForEach(Array(cloudBeaconModel.usefulBeaconNames.keys), id: \.self) { item in
                           
                            BeaconStateView(isNear: cloudBeaconModel.usefulBeaconNames[item] == 1 ? true : false, name: item)
                            
                        }
                    }
                    .padding()
                
                }
                .alert(isPresented: $networkFalse) {
                    Alert(title: Text("获取数据失败"), message: Text("请检查网络后，下滑刷新界面，以重新获取数据"))
                }
                
            }
            .task {
                
                do{
                    try await cloudBeaconModel.startLoop()
                    showLoadingIndicator = false
                    print("isNear: cloudBeaconModel.usefulBeaconNames[item]\( cloudBeaconModel.usefulBeaconNames)")
                }catch {
                    print("Get False")
                    networkFalse = true
                }
            }
            .onAppear {
                showLoadingIndicator = true
               
            }
            .refreshable {
                do{
                    try await cloudBeaconModel.fetchBeacons()
                    showLoadingIndicator = false
                    
                }catch {
                    print("Get False")
                    networkFalse = true
                }
            }
            .padding(.leading)
            .padding(.trailing)
            
            if showLoadingIndicator {
                ProgressView()
            }
            
        }
        
       
    }
}

struct BeaconView_Previews: PreviewProvider {
    static var previews: some View {
        BeaconView()
    }
}
