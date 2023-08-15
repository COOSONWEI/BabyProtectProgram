//
//  GetContacts.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/9.
//

//import Foundation
//import Contacts
//import WatchConnectivity
//
//// 获取通讯录数据
//func fetchContacts() {
//    let store = CNContactStore()
//    let keys = [CNContactGivenNameKey, CNContactFamilyNameKey]
//
//    do {
//        let contacts = try store.unifiedContacts(matching: CNContact.predicateForContacts(matchingName: ""), keysToFetch: keys as [CNKeyDescriptor])
//        let contactNames = contacts.map { "\($0.givenName) \($0.familyName)" }
//        
//        // 使用 WatchConnectivity 发送通讯录数据到 Apple Watch
//        if WCSession.default.isReachable {
//            WCSession.default.sendMessage(["contacts": contactNames], replyHandler: nil, errorHandler: nil)
//        }
//    } catch {
//        print("Error fetching contacts: \(error)")
//    }
//}
