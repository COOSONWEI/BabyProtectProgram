//
//  Image+Extension.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/13.
//

import SwiftUI

//拓展Image
extension Image {
    
    func resizedToFill(width: CGFloat, height: CGFloat) -> some View {
      self
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: width, height: height)
    }
    
}

