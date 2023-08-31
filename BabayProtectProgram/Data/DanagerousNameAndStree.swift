//
//  DanagerousNameAndStree.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/29.
//

import Foundation
import CoreLocation

struct DangerousNameAndStree: Hashable {
    let name: String
    let stree: String
    
    static let dangerous = [
        DangerousListCard(image: "DangerousAreaTest", street: "中国上海市浦东新区陆家嘴陆家嘴环路717号"),
        DangerousListCard(image: "DangerousAreaTest", street: "中国浙江省杭州市西湖区余杭塘路866号")
    ]
}

