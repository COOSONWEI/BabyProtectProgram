//
//  LottieView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/27.
//

import Foundation
//import Lottie
import SwiftUI
import UIKit
//
//struct LottieView: UIViewRepresentable {
//    typealias UIViewType = UIView
//    
//    let filename: String
//    let isLoop: LottieLoopMode
//    
//    func makeUIView(context: UIViewRepresentableContext<LottieView>) ->  UIView {
//        
//        let view = UIView(frame: .zero)
//        //添加lottieAnimationView
//        let animationView = LottieAnimationView()
//        animationView.animation = LottieAnimation.named(filename)
//        animationView.contentMode = .scaleAspectFit
//        animationView.loopMode = isLoop
//        animationView.play()
//        
//        view.addSubview(animationView)
//        animationView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
//            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
//        ])
//        return view
//    }
//    
//    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
//        
//    }
//    
//}
