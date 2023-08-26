//
//  TriviaData.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/24.
//

import Foundation
struct QAModel: Hashable {
    let question: String
    let options: [String:String]
    let answer: String
    
    static let exampleQA = [
        QAModel(question: "在家看见一个颜色鲜艳的水瓶该怎么办？", options: ["A":"想喝就喝","B":"询问爸妈这是什么","C":"就打开闻闻味道","D":"尝一点点"], answer: "B"),
        QAModel(question: "湿的手可以去摸插头嘛？", options: ["A":"不可以","B":"可以","C":"尝试一下可不可以","D":"不知道"], answer: "A"),
        QAModel(question: "发现水果烂了一块，以下说法正确的是？", options: ["A":"可以直接吃掉","B":"应该削皮再吃","C":"削掉腐烂部分就能吃","D":"最好不要吃"], answer: "D")
    ]
}
