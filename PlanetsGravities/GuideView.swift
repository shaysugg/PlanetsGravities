//
//  ARGuideView.swift
//  StudyRealityKit
//
//  Created by Shayan on 5/12/24.
//

import SwiftUI

struct GuideView: View {
    var body: some View {
        Text("Point your camera at a horizontal surface.")
            .foregroundStyle(.white)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .opacity(0.8)
            }
    }
}


#Preview {
    GuideView()
}
