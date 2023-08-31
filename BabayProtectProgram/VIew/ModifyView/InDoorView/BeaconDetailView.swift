//
//  SettingBeaconView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/29.
//

import SwiftUI

//添加界面的状态
enum DetailState {
    //添加至设备
    case addSuccess
    
    //保存设备
    case saveBeacon
    
    //修改设备
    case settingBeacon
}

struct BeaconDetailView: View {
    
    @Binding var uuid: String
    @Binding var name: String
    @State var newName = ""
    @StateObject var bluetoolth: BluetoothModel
    @State private var showAlert = false
    @State private var settingSuccess = false
    
    @State var state: DetailState = .addSuccess
    
    
    var body: some View {
        VStack(spacing:10){
            HStack{
                VStack(alignment:.leading){
                    Text("设备详情")
                        .font(
                            Font.custom("PingFang SC", size: 28)
                                .weight(.medium)
                        )
                        .kerning(1.4)
                        .foregroundColor(Color(red: 0.32, green: 0.32, blue: 0.32))
                }
              
               Spacer()
            }
           
            HStack{
                //界面
                ZStack{
                    Rectangle()
                      .foregroundColor(.clear)
                     
                      .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                      .cornerRadius(14)
                    
                    VStack(alignment:.leading){
                        Image("BeaconsImage")
                            .resizable()
                            .frame(maxWidth: 63, maxHeight: 63)
                            .fixedSize()
                        Text("守护家庭伴侣")
                          .font(
                            Font.custom("PingFang SC", size: 17)
                              .weight(.medium)
                          )
                          .multilineTextAlignment(.center)
                          .foregroundColor(.black)
                        Spacer()
                        Text("二代")
                          .font(Font.custom("PingFang SC", size: 17))
                          .multilineTextAlignment(.center)
                          .foregroundColor(.black)
                    }
                    .padding(.top)
                    .padding(.bottom)
                    .padding(.trailing)
                   
                }
                .frame(maxHeight: 200)
                
                VStack{
                    //房间信息
                    Button {
                        showAlert = true
                    } label: {
                        ZStack{
                            Rectangle()
                              .foregroundColor(.clear)
                             
                              .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                              .cornerRadius(14)
                            VStack(alignment:.leading,spacing: 7){
                                Text("房间")
                                  .font(Font.custom("PingFang SC", size: 12))
                                  .multilineTextAlignment(.center)
                                  .foregroundColor(Color(red: 0.55, green: 0.58, blue: 0.69))
                                HStack{
                                    Text("\(name)")
                                        .font(Font.custom("PingFang SC", size: 17))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .frame(width: 5, height: 10.5)
                                        .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
                                }
                                
                            }
                            .padding()
                            
                        }
                        .frame(maxHeight: 94)
                    }

                   
                    
                    //设备电量
                    ZStack{
                        Rectangle()
                          .foregroundColor(.clear)
                         
                          .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                          .cornerRadius(14)
                        
                        VStack(alignment:.leading,spacing: 7){
                            Text("设备电量")
                              .font(Font.custom("PingFang SC", size: 12))
                              .multilineTextAlignment(.center)
                              .foregroundColor(Color(red: 0.55, green: 0.58, blue: 0.69))
                            
                            HStack{
                                
                                Text("90%")
                                    .font(Font.custom("PingFang SC", size: 17))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                                Spacer()
                                
//                                Image(systemName: "chevron.right")
//                                    .resizable()
//                                    .frame(width: 5, height: 10.5)
//                                    .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
                                
                            }
                            
                        }
                        .padding()
                    }
                    .frame(maxHeight: 94)
                }
            }
            
            //添加按钮
            Button {
                showAlert = true
                state = .settingBeacon
            } label: {
                ZStack{
                    Rectangle()
                      .foregroundColor(.clear)
                      .background(.white)
                      .cornerRadius(15)
                      .shadow(color: Color(red: 0.85, green: 0.85, blue: 0.85).opacity(0.2), radius: 5, x: 0, y: 4)
                    
                    HStack{
                        Text("自定义名称")
                          .font(
                            Font.custom("PingFang SC", size: 17)
                              .weight(.medium)
                          )
                          .multilineTextAlignment(.center)
                          .foregroundColor(.black)
                        
                        Spacer()
                        
                        Text("\(newName)")
                            .font(Font.custom("PingFang SC", size: 17))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.55, green: 0.58, blue: 0.69))
                           
                            .padding(.leading)
                        
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width: 5, height: 10.5)
                            .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
                        
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    
                }
                .frame(maxHeight: 86)
            }

            Spacer()
            
            
            HStack{
                
                //保存设置按钮
                Button {
                    
                    //发送AT指令
                    if newName != "" {
                        bluetoolth.sendATCommand("AT+NAME=\(newName)")
                        settingSuccess = true
                        state = .saveBeacon
                        showAlert = true
                        
                    }
                    
                } label: {
                    HStack() {
                        
                       
                        
                        Text("保存设备")
                          .font(
                            Font.custom("Inter", size: 16)
                              .weight(.semibold)
                          )
                          .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                        
                       
                    }
                    .frame(maxWidth: 164, maxHeight: 41, alignment: .center)
                    .background(.white)
                    .cornerRadius(38.54166)
                    .shadow(color: Color(red: 0.1, green: 0.11, blue: 0.2).opacity(0.06), radius: 2, x: 4, y: 4)
                    .shadow(color: .black.opacity(0.05), radius: 5, x: 1, y: 1)
                    
                }
                
                //添加设备
                Button {
                    state = .addSuccess
                    showAlert = true
                    
                    //发送AT指令
//                    if newName != "" {
//                        bluetoolth.sendATCommand("AT+NAME=\(newName)")
//                        settingSuccess = true
//                        showAlert = true
//
//                    }
                    
                    let add = addBeacons(name: newName)
                    
                } label: {
                    HStack() {
                       
                        Text("添加至设备")
                          .font(
                            Font.custom("Inter", size: 16)
                              .weight(.semibold)
                          )
                          .foregroundColor(.white)
                         
                       
                    }
                    .frame(maxWidth: 164, maxHeight: 41, alignment: .center)
                    .background(Color(red: 1, green: 0.76, blue: 0.78))
                    .cornerRadius(38.54166)
                    .shadow(color: Color(red: 0.1, green: 0.11, blue: 0.2).opacity(0.06), radius: 2, x: 4, y: 4)
                    .shadow(color: .black.opacity(0.05), radius: 3.5, x: 1, y: 1)
                    
                }
            }

        }
        .padding(.leading)
        .padding(.trailing)
        .alert("提示",isPresented: $showAlert) {
            switch state {
            case .addSuccess:
                
                VStack{

                    Button {
                        
                    } label: {
                        Text("添加成功，请前往‘守护设备界面查看新添加的设备").foregroundColor(.gray)
                    }

                    Button {
                        
                    } label: {
                        Text("OK")
                    }
                    
                }
                  
            case .saveBeacon:
                
                VStack{
                    Button {
                        
                    } label: {
                        Text("保存成功")
                            .foregroundColor(.gray)
                    }
                    
                    Button {
                        
                    } label: {
                        Text("OK")
                    }


                }
                    
                
            case .settingBeacon:
                TextField("添加新名称", text: $newName)
                HStack{

                    Button("取消"){
                        newName = ""
                    }

                    Button("确认修改",action: {

                    })
                }
            }
        }
        
//        .alert( settingSuccess ? "保存成功":"自定义新名称",isPresented: $showAlert) {
//            if !settingSuccess {
//                TextField("添加新名称", text: $newName)
//
//                HStack{
//
//                    Button("取消"){
//                        newName = ""
//                    }
//
//                    Button("确认修改",action: {
//
//                    })
//                }
//            }else{
//                Button {
//                    settingSuccess = false
//                } label: {
//                    Text("OK")
//                }
//
//            }
//
//        }
    }
    
}


extension BeaconDetailView {
    
    func addBeacons(name: String) -> Bool {

        if name != "" {
            
            let beaconModel = BeaconModel()
            beaconModel.beaconName = Beacon(name: name, subTitle: "")
            
            let cloudStore = CloudBeaconModel()
            cloudStore.saveNewBeaconToCloud(beaconModel: beaconModel)
            print("add True")
            
            state = .addSuccess
            return true
            
        }else{
//            isValid = true
            
//            state = .addFalse
            
            return false
        }
    }
    
}

struct BeaconDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BeaconDetailView(uuid: .constant("xxx"), name: .constant("厨房"), bluetoolth: BluetoothModel())
    }
}
