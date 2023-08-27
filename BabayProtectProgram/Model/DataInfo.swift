//
//  DataInfo.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/16.
//

import Foundation

//数据文件
//电话数据文件
class DataInfo: ObservableObject {
    //是否是第一次打开应用
    @Published var firstuse: Int = -1
    //电话内容
    @Published var phone: String? = nil
}


//邮箱数据文件
class EmailInfo: ObservableObject {
    //是否是第一次运行
    @Published var firstuse: Int = -1
    //邮箱
    @Published var email: String? = nil
    //密码
    @Published var passWord: String? = nil
    
}

