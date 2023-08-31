//
//  Color+Extension.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/30.
//

import Foundation
import SwiftUI

//十六进制的色彩拓展
extension Color {
    init(hex: UInt32) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
