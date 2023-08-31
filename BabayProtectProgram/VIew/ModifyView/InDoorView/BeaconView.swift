//
//  BeaconView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/27.
//

import SwiftUI
//import Lottie


enum DeleteState {
    case isdelete
    case netFalse
}

struct BeaconView: View {
    
    @StateObject var cloudBeaconModel: CloudBeaconModel
    @StateObject var bluetoolthModel = BluetoothModel()
    
    @State private var showLoadingIndicator = false
    
    @State private var networkFalse = false
    @State var dataState: DeleteState = .netFalse
    @State var isNil = false
    @State private var showDeleteButton = false
    @State private var selectedItem: String? // 用于记录长按的元素
    
    @State var showAlert = false
    
    var body: some View {
        
        NavigationView{
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
                        
                        //通知设置
                        Button {
                            
                        } label: {
                            Image(systemName: "bell")
                                .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.09))
                            
                        }
                        .frame(width: 28, height: 29)
                        
                        //添加修改设备
                        NavigationLink {
                            FindingAndSettingBeaconView(bluetoothModel: bluetoolthModel)
                                .navigationBarBackButtonHidden(true)
                                .navigationBarItems(leading: BackButtonView())
                            
                        } label: {
                            Image(systemName: "plus.circle")
                                .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.09))
                            
                                .frame(width: 29, height: 29)
                        }
                        
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
                                .foregroundColor(cloudBeaconModel.penalizedDeviceName != nil ? .red : .green)
                            
                            //触发的信标名称，时间(预留一个量去改变它的位置)
                            Text(cloudBeaconModel.penalizedDeviceName != nil ? "孩子正在靠近\(cloudBeaconModel.penalizedDeviceName!)危险区" : "孩子未进入危险区")
                                .font(.custom("PingFang SC", size: 13))
                                .fontWeight(.medium)
                                .foregroundColor(Color(red: 0.05, green: 0.05, blue: 0.05))
                            
                            Text(cloudBeaconModel.modifiedDate != nil ? "\(cloudBeaconModel.modifiedDate!)信标被触发" : "没有信标被触发")
                                .multilineTextAlignment(.center)
                                .font(.custom("PingFang SC", size: 12))
                                .foregroundColor(Color(red: 0.64, green: 0.64, blue: 0.64))
                        }
                        
                    }
                    .frame(maxHeight: 268)
                    
                    Text("没有信标被添加，请前往首页中添加室内信标")
                        .multilineTextAlignment(.leading)
                        .font(.custom("PingFang SC", size: 12))
                        .foregroundColor(Color(red: 0.64, green: 0.64, blue: 0.64))
                        .opacity(isNil ? 1 : 0)
                    Text("数据更新具有一定延时性，请确保网络环境通畅")
                        .multilineTextAlignment(.leading)
                        .font(.custom("PingFang SC", size: 12))
                        .foregroundColor(Color(red: 0.64, green: 0.64, blue: 0.64))
                    
                    //MARK: -这里是之前的代码
                    //                    ScrollView(.vertical,showsIndicators: false){
                    //
                    //                        //加载已添加的信标和它的状态
                    //                        LazyVGrid(columns: [
                    //                            GridItem(.flexible(), spacing: 16),
                    //                            GridItem(.flexible(), spacing: 16)
                    //                        ], spacing: 23) {
                    //
                    //                            ForEach(Array(cloudBeaconModel.usefulBeaconNames.keys), id: \.self) { item in
                    //
                    //                                BeaconStateView(isNear: cloudBeaconModel.usefulBeaconNames[item] == 1 ? true : false, name: item)
                    //                            }
                    //                        }
                    //                        .padding()
                    //                    }
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 16),
                            GridItem(.flexible(), spacing: 16)
                        ], spacing: 23) {
                            ForEach(Array(cloudBeaconModel.usefulBeaconNames.keys), id: \.self) { item in
                                VStack {
                                    BeaconStateView(isNear: cloudBeaconModel.usefulBeaconNames[item] == 1 ? true : false, name: item,isDelete: $showAlert,state: $dataState)
                                        .alert(isPresented: $showAlert) {
                                            switch dataState {
                                            case .isdelete:
                                              return  Alert(title: Text("提示"), message: Text("您确定要删除吗？若删除后还存在您删除后的信标可退出程序后再回到该界面即可刷新成功！"), primaryButton: .cancel(Text("取消")), secondaryButton: .default(Text("确认删除"), action: {
                                                    Task{
                                                        print("Delete ")
                                                       await cloudBeaconModel.deleteBeaconsWithNames([item])
                                                        cloudBeaconModel.usefulBeaconNames.removeValue(forKey: item)
                                                    }
                                                   
                                                }))
                                            case .netFalse:
                                               return Alert(title: Text("获取数据失败"), message: Text("请检查网络后，下滑刷新界面，以重新获取数据"))
                                            }
                                            
                                        }
//                                    Button(action: {
//                                        // 在这里处理删除操作
//                                        print("item = \(item)")
////                                        Task{
////                                            try await cloudBeaconModel.deleteBeaconsWithNames([item])
////                                        }
//
////                                        cloudBeaconModel.usefulBeaconNames[item] = nil // 删除对应的数据
//                                    }) {
//                                        Image(systemName: "trash")
//                                            .foregroundColor(.red)
//                                    }
                                }
                            
                                
                                }
                            }
                            
                        }
                        .padding()
                    }
                    
                    
                }
                .task {
                    do{
                        try await cloudBeaconModel.fetchBeacons()
                        showLoadingIndicator = false
                        print("isNear: cloudBeaconModel.usefulBeaconNames[item]\( cloudBeaconModel.usefulBeaconNames)")
                        if cloudBeaconModel.beaconNames.count > 0 {
                            isNil = false
                        }else{
                            isNil = true
                        }
                        
                    }catch {
                        print("Get False")
                        showLoadingIndicator = false
                        dataState = .netFalse
                        showAlert = true
                        isNil = true
                    }
                }
                .onAppear {
                    showLoadingIndicator = true
//                    cloudBeaconModel.resumeLoop()
                }
                .onDisappear(perform: {
                    print("I am Disappear...")
                    cloudBeaconModel.pauseLoop()
                })
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
        BeaconView(cloudBeaconModel: CloudBeaconModel())
    }
}
