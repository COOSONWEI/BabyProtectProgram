//
//  PuzzleView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/30.
//

import SwiftUI

//仅仅只是一张图片的
struct PuzzleView: View {
    @State private var circlePositions: [IdentifiablePoint] = []
 
    @Binding var right: Int
    
    let geometrys = [
        CGPoint(x: 285.0, y: 557.0),
        CGPoint(x: 64.0, y: 548.0),
        CGPoint(x: 97.0, y: 192.0),
        CGPoint(x: 158.0, y: 285.0)
        
    ]
    
    @State private var isWithinArea = false
    
    let image = Image("PuzzleOne") // Replace with your own image name
    
    
    var body: some View {
        ZStack {
            image
                .onTapGesture {
                    location in
                    isWithinArea =  isWithinTappableArea(location, geometry: geometrys).1
                    print(location)
                    print(isWithinArea)
                    if isWithinArea {
                        circlePositions.append(IdentifiablePoint(point: isWithinTappableArea(location, geometry: geometrys).0))
                        if right < 4 {
                            right += 1
                        }
                    }
                }
            
            ForEach(circlePositions) { point in
                Circle()
                    .fill(Color.red.opacity(0.4))
                    .frame(width: 50, height: 50)
                    .position(point.point)
                
            }
        }
       
        
    }
    
    private func isWithinTappableArea(_ position: CGPoint, geometry: [CGPoint]) -> (CGPoint,Bool) {
        /*
         TapLocation(255.66666158040366, 400.3333282470703)
         
         */
        
        //判断是否在区域里面
        for positions in geometry {
            
            if positions.x + 50.0 >= position.x && positions.x - 50.0 <= position.x && positions.y + 20.0 >= position.y && positions.y - 150.0 <= position.y
            {
                return (positions,true)
            }
        }
        
        return (position,false)
        
    }
}


struct IdentifiablePoint: Identifiable {
    let id = UUID()
    let point: CGPoint
}


struct PuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleView(right: .constant(0))
    }
}
