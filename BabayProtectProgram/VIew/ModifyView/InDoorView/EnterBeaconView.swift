//
//  EnterBeaconButton.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/16.
//

import SwiftUI

struct EnterBeaconView: View {
   
    //添加上下文存入CoreData
    @Environment(\.managedObjectContext) var context
    //联系人数据
    @StateObject var cloudModel: CloudBeaconModel
    
    @State private var name: String = ""
    
    @State private var isValid: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            Image(systemName: "phone.fill")
                .font(.largeTitle)
                .foregroundColor(.pink.opacity(0.2))
            
            TextField("信标名称", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color(red: 0.98, green: 0.91, blue: 0.76))
                .cornerRadius(10)
            
            Button(action: {
                // 添加按钮点击事件
                addContacts(name: name)
            }) {
                Text("添加")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(20)
                    .shadow(radius: 3)
            }
            .alert(isPresented: $isValid) {
                Alert(title: Text("提示"),message: Text("信标名称输入不规范请重新输入"))
            }
        }
        .padding()
    }
    
    func addContacts(name: String) {
        
        if name != "" {
            
            
                let contactsModel = BeaconModel()
                contactsModel.beaconName = Beacon(name: name)
            
                let cloudStore = CloudBeaconModel()
               cloudStore.saveNewBeaconToCloud(beaconModel: contactsModel)
            
        }else{
            isValid = true
        }
    }
    
}

struct EnterBeaconButton_Previews: PreviewProvider {
    static var previews: some View {
        EnterBeaconView(cloudModel: CloudBeaconModel())
    }
}
