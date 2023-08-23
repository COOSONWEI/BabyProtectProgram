//
//  DrawingHistoryPath.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/19.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation

struct NavigationsView: UIViewControllerRepresentable {
    
    let sourceCoordinate = CLLocationCoordinate2D(latitude: 39.916345, longitude: 116.397155)
    let destinationCoordinate = CLLocationCoordinate2D(latitude: 31.234040, longitude: 121.474366)

    func makeUIViewController(context: Context) -> UIViewController {
        let view = UIViewController()
        context.coordinator.viewController = view
        context.coordinator.loadUI()
        context.coordinator.drawThePath()
        return view
    }
   

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> HsitoryMapViewCoordinator {
        HsitoryMapViewCoordinator(sourceCoordinate: sourceCoordinate, destinationCoordinate: destinationCoordinate)
    }
    
}

struct DrawingHistoryView: View {
    
    var body: some View {
        NavigationsView()
            .ignoresSafeArea()
    }
    
}

struct DrawingHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingHistoryView()
    }
}
