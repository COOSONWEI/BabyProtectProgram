//
//  RemainDecimalPoint.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/30.
//

import Foundation

//保留小数点后6位
func formatDecimalNumber(_ number: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.roundingMode = .down
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 6
    if let formattedString = formatter.string(from: NSNumber(value: number)) {
        return formattedString
    }
    return ""
}

