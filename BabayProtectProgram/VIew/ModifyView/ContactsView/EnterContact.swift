//
//  EnterContact.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/16.
//

import SwiftUI

//添加联系人界面(同步到watch端)
struct EnterContact: View {
    
    //添加上下文存入CoreData
    @Environment(\.managedObjectContext) var context
    //联系人数据
    @StateObject var contact: Contacts
    @StateObject var phoneModel = phoneNumberModel()
    @State private var name: String = ""
    @State private var phoneNumber: String = ""
    @State var isFalseEnter = false
    
    @State private var isValid: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            Image(systemName: "phone.fill")
                .font(.largeTitle)
                .foregroundColor(.pink.opacity(0.2))
            
            
            TextField("姓名", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color(red: 0.98, green: 0.91, blue: 0.76))
                .cornerRadius(10)
            
            TextField("电话号码", text: $phoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color(red: 0.53, green: 0.66, blue: 0.85)
                    .shadow(radius: 3))
                .cornerRadius(10)
            
            Button(action: {
                // 添加按钮点击事件
                addContacts(name: name, phone: phoneNumber)
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
                Alert(title: Text("提示"),message: Text("名称或手机号输入不规范请重新输入"))
            }
        }
        .padding()
    }
    
    func addContacts(name: String, phone: String) {
        
        if name != "" && phone != ""  {
            
            if validatePhoneNumber(phone) {
                let contactsModel = phoneNumberModel()
                contactsModel.name = name
                contactsModel.phoneNumber = phone
                let cloudStore = Contacts()
                cloudStore.saveRecordToCloud(contact: contactsModel)
            }
        }else{
            isValid = true
        }
    }
    
    //利用正则表达式判断输入的手机号是否正确
    func validatePhoneNumber(_ number: String) -> Bool {
        let phoneRegex = "^[0-9]{11}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        isValid = phonePredicate.evaluate(with: number)
        return isValid
    }
    
    
}

struct EnterContact_Previews: PreviewProvider {
    static var previews: some View {
        EnterContact(contact: Contacts())
    }
}
