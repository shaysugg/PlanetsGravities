//
//  ViewRepresentables.swift
//  StudyRealityKit
//
//  Created by Shayan on 4/21/24.
//

import UIKit
import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    let state: EnvironmentState
    
    func makeUIView(context: Context) -> ARFallingView {
        let view = ARFallingView(state: state)
        view.setup()
        return view
        
    }
    
    func updateUIView(_ uiView: ARFallingView, context: Context) {}
    
}
