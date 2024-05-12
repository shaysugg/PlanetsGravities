//
//  ContentView.swift
//  StudyRealityKit
//
//  Created by Shayan on 4/21/24.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @State private var isEnvironmentMenuCollapsed = false
    @StateObject private var state = EnvironmentState()
    
    var body: some View {
        ZStack {
            ARViewContainer(state: state)
                .edgesIgnoringSafeArea(.all)
            
            if state.falling == .configuring {
                GuideView()
            }
            
            if state.falling != .configuring {
                VStack {
                    Spacer()
                    EnvironmentMenu(state: state)
                        .frame(maxWidth: 500)
                        .padding(5)
                }
            }
        }
    }
}

