//
//  ContactAddView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/23.
//

import SwiftUI

struct ContactAddView: View {
    
    @StateObject var contacts = Contacts()
    
    @State private var items: [String] = ["Item 1", "Item 2", "Item 3"]
    
    @State var show = false
    @State private var deleteItem = false
    
    //    @State private var addDangerous
    
    var body: some View {
        
        ZStack {
            VStack{
                HStack{
                    Text("请添加家长的电话，我们将会将联系人号码同步到您孩子的手表中。")
                        .font(
                        Font.custom("SF Pro Display", size: 15.6)
                        .weight(.semibold)
                        )
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .foregroundColor(Color(red: 0.53, green: 0.53, blue: 0.51))
                        .padding(.leading)
                }
                
                List{
                    //                        cloudBeaconModel.usefulBeaconNames.keys.sorted()
                    ForEach(contacts.contacts,id:\.self){ data in
                        
                        DangerGeofenceCard(name: data.name, phone: data.phoneNumber)
                        
                    }
                    .onDelete { offsets in
                        Task {
                            await self.deleteContacts(at: offsets)
                        }
                    }
                    
                }
                .listStyle(.plain)
                HStack{
                    Spacer()
                    AddPhoneNumber(sheetView: $show)
                        .padding(.trailing)
                    
                }
                .sheet(isPresented: $show) {
                    AddContactButton(contact: contacts)
                        .presentationDetents([.medium])
                }
                
            }
            
            //                AddBeaconView(show: $show, cloudModel: cloudBeaconModel, showAlert: .constant(false))
            //                    .offset(y: -50)
            //                    .opacity(show ? 1 : 0)
            
        }
        .alert(isPresented: $deleteItem, content: {
            Alert(title: Text("提示"), message: Text("删除成功，请退出当前界面再次进入以获取删除后的数据"))
        })
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                    BackButtonView()
        )
        .task {
            do{
                try await contacts.fetchContacts()
            }catch{
                print("lalalal")
            }
        }
        .refreshable {
            do{
                try await contacts.fetchContacts()
            }catch{
                print("refresh")
            }
        }
        
        
    }
    
    func deleteItem(at offsets: IndexSet) {
        
        items.remove(atOffsets: offsets)
        
    }
    
    func deleteContacts(at offsets: IndexSet) async {
        let contactNamesToDelete = offsets.map { contacts.contanctsData[$0].object(forKey: "name") as! String}
        do{
            await contacts.deleteContactsNames(contactNamesToDelete)
            withAnimation {
                deleteItem = true
                contacts.objectWillChange.send()
            }
        }catch{
            
        }
       
    }
    
}



struct AddContactButton: View {
    
    @StateObject var contact: Contacts
    @StateObject var phoneModel = phoneNumberModel()
    @State private var name: String = ""
    @State private var phoneNumber: String = ""
    @State var isFalseEnter = false
    @State private var isValid: Bool = false
    @State private var showAlert: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    
                    TextField("姓名", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    TextField("电话号码", text: $phoneNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                }
                .listStyle(.plain)
                
            }
            .navigationBarItems(
                leading: Button(action: {
                    //取消返回
                    presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Text("取消")
                },
                trailing: Button(action: {
                    // 当输入后才能点完成
                    
                    addContacts(name: name, phone: phoneNumber)
                  
                    if isFalseEnter == false {
                        presentationMode.wrappedValue.dismiss()
                    }
                    isFalseEnter = true
                    
                }) {
                    Text("完成")
                }.disabled(!validatePhoneNumber(phoneNumber))
                .alert(isPresented: $isFalseEnter) {
                        Alert(title: Text("提示"),message: Text("添加成功，请下滑刷新数据"))
                }
                
            )
            
            
        }
        
    }
    
    func addContacts(name: String, phone: String) {
        
        if name != "" && phone != ""  {
            if validatePhoneNumber(phone) {
                let contactsModel = phoneNumberModel()
                contactsModel.name = name
                contactsModel.phoneNumber = phone
                let cloudStore = Contacts()
                cloudStore.saveRecordToCloud(contact: contactsModel)
                isFalseEnter = false
            }
            
        }else{
            isValid = true
            isFalseEnter = true
        }
        
    }
    
    //利用正则表达式判断输入的手机号是否正确
    func validatePhoneNumber(_ number: String) -> Bool {
        let phoneRegex = "^[0-9]{11}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        print("judge\(isValid)")
        DispatchQueue.main.async {
            self.isValid = phonePredicate.evaluate(with: number)
        }
       
        return isValid
    }
    
}


struct ContactAddView_Previews: PreviewProvider {
    static var previews: some View {
        ContactAddView()
    }
}
