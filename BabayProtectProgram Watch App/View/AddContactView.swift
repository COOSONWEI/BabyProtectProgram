//
//  AddContactView.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/9.
//

import SwiftUI

struct AddContactView: View {
    
    @State private var contactName: String = ""
    @State private var contactNumber: String = ""
    @StateObject var contacts: Contacts
    @State private var isValid: Bool = true
    @State private var isFalseEnter = false
    var body: some View {
        VStack{
            TextField("请填写联系人的姓名", text: $contactName)
            TextField("请填写联系人的电话", text: $contactNumber)
            Button {
                addContacts(name: contactName, phoneNumber: contactNumber)
            } label: {
                Text("完成")
            }
            .alert("提示", isPresented: $isValid) {
                Text("输入的手机号或联系人姓名规格错误请重新输入")
            }
            .alert(isPresented: $isFalseEnter) {
                Alert(title: Text("提示"),message: Text("信标添加成功"))
            }
        }
        .navigationTitle("添加联系人")
        
    }
    
    func addContacts(name: String, phoneNumber: String) {
        //输入判断
        if validatePhoneNumber(phoneNumber) {
            contacts.contacts.append(PhoneNumber(name: name, phoneNumber: phoneNumber))
            isValid = false
            isFalseEnter = true
        }else{
            isValid = true
            isFalseEnter = false
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

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(contacts: Contacts())
            
    }
}
