//
//  EnvironmentView.swift
//  StudyRealityKit
//
//  Created by Shayan on 5/4/24.
//

import SwiftUI

struct EnvironmentMenu: View {
    @ObservedObject var state: EnvironmentState
    private var isStarted: Bool { state.falling == .performing }
    
    @State private var isCollapsed = false
    @State private var lastCollapse: Bool?
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                startButton
                Spacer()
                collapseButton
            }.padding(5)
            
            
            if !isCollapsed {
                Divider()
                
                Text("Planets")
                planetSelector
                
                Divider()
                
                Text("Initial Velocity")
                velocitySelector
                
                Text("Remaining Velocity on each bounce")
                velocityReduceOnBounceSelector
            }
        }
        .padding()
        .foregroundColor(.white)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.black).opacity(0.7))
        .animation(.easeIn(duration: 0.1), value: isCollapsed)
        .onChange(of: isStarted) { isStarted in
            if isStarted {
                lastCollapse = isCollapsed
                isCollapsed = true
            }else {
                isCollapsed = lastCollapse ?? false
            }
        }
    }
    
    @ViewBuilder var planetSelector: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(Planet.all, id: \.name) { planet in
                    VStack {
                        let selected = planet.name == state.planet.name
                        Image(planet.name)
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .overlay(content: {
                                Circle()
                                    .stroke(selected ? Color.cyan : Color.clear, lineWidth: 3)
                            })
                        
                        VStack {
                            Text(planet.name)
                            Text(String(format: "%.2f m/s^2", planet.gravityAcceleration))
                                .font(.caption2)
                        }
                        .padding(2)
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(selected ? Color.cyan: Color.clear)
                        }
                        
                    }.onTapGesture {
                        state.planet = planet
                    }
                }
            }
            
        }
    }
    
    @ViewBuilder var velocitySelector: some View {
        HStack {
            Slider(value: $state.velocity, in: (1...12), label: {
                Text("Velocity")
            })
            Text(String(format: "%.2f m/s", state.velocity))
        }
    }
    
    @ViewBuilder var velocityReduceOnBounceSelector: some View {
        HStack {
            Slider(value: $state.remainingVelocityOnBounce, in: (0...1), step: 0.1, label: {
                Text("Remaining Velocity on bounce")
            })
            Text(String(format: "%.f", state.remainingVelocityOnBounce * 100) + "%")
        }
    }
    
    @ViewBuilder var collapseButton: some View {
        Button {
            isCollapsed.toggle()
        } label: {
            Image(systemName: isCollapsed ? "chevron.up" : "chevron.down")
        }
        .opacity(isStarted ? 0 : 1)
        .disabled(isStarted)
    }
    
    @ViewBuilder var startButton: some View {
        Button {
            if !isStarted {
                state.start()
            }else {
                state.stop()
            }
        } label: {
            Image(systemName: isStarted ? "pause.fill" : "play.fill")
        }
    }
}


struct TestView: View {
    @State private var isEnvironmentMenuCollapsed = false
    @StateObject private var state = EnvironmentState()
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Color.green.ignoresSafeArea(.all)
            EnvironmentMenu(state: state)
                .padding(5)
                .frame(maxWidth: 500)
//                .frame(maxHeight: 300)
        }
            
    }
}

#Preview {
    TestView()
}
