//
//  CallModifyView.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/9.
//

import SwiftUI
import WatchKit
import Contacts

struct CallModifyView: View {
    let name: String
    let phoneNumber: String
    let index: Int
    let contactsModle: Contacts
    @State var addContact = false
    var body: some View {
        
        //第一个是录入联系人，后面的是通讯录
        Button {
            callContact(phoneNumber)
        } label: {
            ZStack{
                Image("CallBG")
                    .resizable()
                    .scaledToFill()
                Image(systemName: "phone")
                    .resizable()
                    .scaleEffect(0.2)
                VStack{
                    Spacer()
                    Text(name)
                        .font(.system(size: 22.18816))
                        .fontWeight(.bold)
                }
            }
            .frame(maxWidth: 179.9575, maxHeight: 170.2912)
          
        }
        .scaledToFit()
        .buttonStyle(CustomButtonStyle())
    }
    
    func jumptoAddContact() {
        addContact.toggle()
    }
}

struct CallModifyView_Previews: PreviewProvider {
    static var previews: some View {
        CallModifyView(name: "110", phoneNumber: "19184494122", index: 1, contactsModle: Contacts())
    }
}
