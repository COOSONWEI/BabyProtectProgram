//
//  CallPhoneButtonView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/23.
//

import SwiftUI

struct CallPhoneButtonView: View {
    
    @State var enterAddDangerous = false
    @State var enterIndoorDangerous = false
    @State private var enterAddBabyphone = false
    
    @State var dataInfo = [DataInfo]()
    @State var phone = ""
    @State var notAddPhone = false
    @State private var isNill = false
    
    
    var body: some View {
        ZStack{
            Rectangle()
              .foregroundColor(.clear)
             
              .background(Color(red: 0.62, green: 0.62, blue: 0.95))
              .cornerRadius(25)
            
            HStack{
                VStack{
                    Text("孩子安全家长放心\n一键呼叫")
                        .foregroundColor(.white)
                        .lineLimit(nil)
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    
                    //创建拨打电话按钮
                    Button {
                        readData()
                        print("phone = \(phone)")
                        if phone == "" {
                            print("lalala")
                            notAddPhone = true
                        }else{
                            notAddPhone = false
                            callContact(phone)
                        }
                      
                      
                        
                    } label: {
                            
                        Text("点击呼叫宝贝")
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 23)
                    .padding(.vertical, 7)
                    .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                    .cornerRadius(40)

                }
                .padding(.leading)
                
                ZStack{
                    Image("CallBaby")
                    Image("Compass")
                        .offset(x: 60, y: -70)
                }
              
                
            }
        }
        .frame(maxHeight: 140)
        .alert(isPresented: $isNill) {
            Alert(title: Text("提示"), message: Text("请在Watch端打开“守护”App进行第一次数据同步"))
        }
        .alert(isPresented: $notAddPhone) {
           
            Alert(title: Text("提示"), message: Text("请添加宝贝的电话"), primaryButton: .default(Text("OK"), action: {
                enterAddBabyphone = true
            }), secondaryButton: .cancel())
           
        }
        .onAppear(perform: {
            if DataManager.isFirstRuning() {
                print("第一次运行程序")
                isNill = true
            }else{
                isNill = false
            }
        })
        .sheet(isPresented: $enterAddBabyphone) {
            AddBabayPhone()
                .presentationDetents([.medium,.large])
        }
       
    }
    private func readData() {
        //读孩子的电话数据
        dataInfo = DataManager.readData()
        for info in dataInfo {
            phone = info.phone ?? ""
        }
    }
}

struct CallPhoneButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CallPhoneButtonView()
    }
}
