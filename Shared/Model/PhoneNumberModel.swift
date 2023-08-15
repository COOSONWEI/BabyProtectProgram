//
//  PhoneNumberModel.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/9.
//

import Foundation
import WatchConnectivity

//创建一个手机联系人的数据模型
struct PhoneNumber: Hashable {
    let name: String
    let phoneNumber: String
}

//存放数据的数组
class Contacts: ObservableObject {
    @Published var contacts: [PhoneNumber] = [PhoneNumber(name: "", phoneNumber: ""),PhoneNumber(name: "爸爸", phoneNumber: "19184494122"),PhoneNumber(name: "妈妈", phoneNumber: "19184494122"),PhoneNumber(name: "110", phoneNumber: "110")]
    
    //测试用的数据
    let testContacts = [PhoneNumber(name: "", phoneNumber: ""),PhoneNumber(name: "爸爸", phoneNumber: "19184494122"),PhoneNumber(name: "妈妈", phoneNumber: "19184494122"),PhoneNumber(name: "110", phoneNumber: "110")]
}


