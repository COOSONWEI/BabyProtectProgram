//
//  CallPhoneView.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/9.
//

import SwiftUI
import WatchConnectivity
import Contacts
import WatchKit

struct CallPhoneView: View {
    @State private var contactNames: [String] = []
    @StateObject var contactsModel: Contacts
    
    var body: some View {
        
        TabView{
            ForEach(contactsModel.contacts.indices,id: \.self) {index in
                CallModifyView(name: contactsModel.contacts[index].name,phoneNumber: contactsModel.contacts[index].phoneNumber,index: index,contactsModle: contactsModel)
            }
        }
    }
    
    //获取手机通讯录联系人
    func fetchContacts() {
        let store = CNContactStore()
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey]
        
        store.requestAccess(for: .contacts) { granted, error in
            if granted {
                do {
                    let contacts = try store.unifiedContacts(matching: CNContact.predicateForContacts(matchingName: ""), keysToFetch: keys as [CNKeyDescriptor])
                    let contactNames = contacts.map { "\($0.givenName) \($0.familyName)" }
                    
                    DispatchQueue.main.async {
                        self.contactNames = contactNames
                    }
                } catch {
                    print("Error fetching contacts: \(error)")
                }
            } else {
                print("Access denied")
            }
        }
    }
    
    
}

struct CallPhoneView_Previews: PreviewProvider {
    static var previews: some View {
        CallPhoneView(contactsModel: Contacts())
    }
}
