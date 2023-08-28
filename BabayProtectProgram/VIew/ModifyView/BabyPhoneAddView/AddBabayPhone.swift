//
//  AddBabayPhone.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/16.
//

import SwiftUI

struct AddBabayPhone: View {
    
    //添加上下文存入CoreData
    @Environment(\.managedObjectContext) var context
    
    //宝贝的手机号
    @State var babyPhoneArry: [DataInfo] = []
    @ObservedObject var babyPhone = DataInfo()

    @State private var phone = ""
    @State private var isValid: Bool = false
    @State private var enterRight: Bool = false
    @State private var enterFalse: Bool = false
    @State private var showAlert = false
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "phone.fill")
                .font(.largeTitle)
                .foregroundColor(.pink.opacity(0.2))
            
            TextField("宝贝手机号", text: $phone)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color(red: 0.98, green: 0.91, blue: 0.76))
                .cornerRadius(10)
            
            Button(action: {
                // 添加按钮点击事件
//                enterFalse = !validatePhoneNumber(phone)
//                enterRight = validatePhoneNumber(phone)
                addContacts(phone: phone)
                showAlert = true
            }) {
                Text("添加")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(20)
                    .shadow(radius: 3)
            }
//            .alert(isPresented: $enterRight, content: {
//
//                Alert(title: Text("添加成功"),message: Text("目前的手机号为：\(phone)"))
//            })
//
//            .alert(isPresented: $enterFalse) {
//                Alert(title: Text("提示"),message: Text("手机号输入不规范请重新输入"))
//            }
        }
        .onTapGesture {
            print("enterRight === \(enterRight)")
        }
        .padding()
        .alert(isPresented: $showAlert) {
           Alert(title: Text(enterRight ? "添加成功" : "提示"), message: Text(enterRight ? "目前的手机号为：\(phone)" : "手机号输入不规范请重新输入"))
        }
        
    }
    
    func addContacts(phone: String) {
        
            if !validatePhoneNumber(phone) {
                isValid = true
                enterRight = false
                enterFalse = true
            }else{
                babyPhone.firstuse = 0
                babyPhone.phone = phone
                // 保存数据
                babyPhoneArry = DataManager.readData()
                for phoneNumber in  babyPhoneArry {
                    if phoneNumber.phone != babyPhone.phone {
                        phoneNumber.phone = babyPhone.phone
                    }
                }
                DataManager.writeDate(dataInfoArr: babyPhoneArry)
                print("添加联系人成功")
                isValid = false
                enterRight = true
            }
            
        
    }
    
    func validatePhoneNumber(_ number: String) -> Bool {
        let phoneRegex = "^[0-9]{11}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        isValid = phonePredicate.evaluate(with: number)
        print("judge\(isValid)")
        
        return isValid
    }
    
    
}

struct Hobby:Identifiable {
    let id = UUID()
    let title: String
    let Message: String
}

struct AddBabayPhone_Previews: PreviewProvider {
    static var previews: some View {
        AddBabayPhone()
    }
}
