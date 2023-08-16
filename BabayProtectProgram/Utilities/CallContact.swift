//
//  CallContact.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/16.
//

import UIKit

func callContact(_ contact: String) {
    
    if contact != "" {
        // 创建一个电话 URL
        let telURLString = "tel:\(contact)"
        if let telURL = URL(string: telURLString) {
            // 使用 UIApplication 的 open 方法来触发电话拨号
            if UIApplication.shared.canOpenURL(telURL) {
                UIApplication.shared.open(telURL, options: [:], completionHandler: nil)
            }
        }
    }
    
}

