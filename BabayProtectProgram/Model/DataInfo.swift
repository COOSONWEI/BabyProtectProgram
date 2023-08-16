//
//  DataInfo.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/16.
//

import Foundation

class DataInfo: ObservableObject {
    //是否是第一次打开应用
    @Published var firstuse: Int = -1
    //电话内容
    @Published var phone: String = ""
}
