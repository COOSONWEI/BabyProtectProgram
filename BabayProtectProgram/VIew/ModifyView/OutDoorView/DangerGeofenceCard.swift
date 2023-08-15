//
//  DangerGeofenceCard.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/13.
//

import SwiftUI

struct DangerGeofenceCard: View {
    let image:Image
    var body: some View {
        image
            .resizedToFill(width: 375, height: 195)
            .clipShape(Rectangle())
            .cornerRadius(15)
    }
}



struct DangerGeofenceCard_Previews: PreviewProvider {
    static var previews: some View {
        DangerGeofenceCard(image: Image("DangerousAreaTest"))
    }
}
