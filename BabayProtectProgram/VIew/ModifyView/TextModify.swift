//
//  TextModify.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/11.
//

import SwiftUI

struct TextModify: ViewModifier {
    let fontName: String
    let fontSize: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.custom("", size: 0))
        
    }
}


