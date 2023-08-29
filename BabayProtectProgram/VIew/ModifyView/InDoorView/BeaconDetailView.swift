//
//  SettingBeaconView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/29.
//

import SwiftUI

struct BeaconDetailView: View {
    
    @Binding var uuid: String
    @Binding var name: String
    @State var newName = ""
    @StateObject var bluetoolth: BluetoothModel
    @State private var showAlert = false
    @State private var settingSuccess = false
    
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
            
            //保存设置按钮
            Button {
                
                //发送AT指令
                if newName != "" {
                    bluetoolth.sendATCommand("AT+NAME=\(newName)")
                    settingSuccess = true
                    showAlert = true
                    
                }
                
            } label: {
                HStack(alignment: .center) {
                    
                    
                    Spacer()
                    
                    Text("保存设置")
                        .foregroundColor(.white)
                    Spacer()
                    
                    
                }
                .padding(.horizontal, 69)
                .padding(.vertical, 7)
                .frame(maxWidth: 276, alignment: .center)
                .background(Color(red: 0.39, green: 0.57, blue: 0.76))
                .cornerRadius(38.54166)
                .shadow(color: Color(red: 0.1, green: 0.11, blue: 0.2).opacity(0.1), radius: 11.5625, x: 0, y: 15.41667)
            }
        }
        .padding(.leading)
        .padding(.trailing)
        .alert( settingSuccess ? "保存成功":"自定义新名称",isPresented: $showAlert) {
            if !settingSuccess {
                TextField("添加新名称", text: $newName)
                
                HStack{
                    
                    Button("取消"){
                        newName = ""
                    }
                    
                    Button("确认修改",action: {
                        
                    })
                }
            }else{
                Button {
                    settingSuccess = false
                } label: {
                    Text("OK")
                }

            }
           
        }
    }
}

struct BeaconDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BeaconDetailView(uuid: .constant("xxx"), name: .constant("厨房"), bluetoolth: BluetoothModel())
    }
}
