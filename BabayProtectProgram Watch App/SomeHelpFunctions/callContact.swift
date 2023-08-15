//
//  callContact.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/9.
//

import Foundation
import Contacts
import WatchKit

func callContact(_ contact: String) {
        // 创建一个电话 URL
        let telURLString = "tel:\(contact)"
        if let telURL = URL(string: telURLString) {
            // 调用 openSystemURL 来触发电话拨号
            WKExtension.shared().openSystemURL(telURL)
        }
    }
