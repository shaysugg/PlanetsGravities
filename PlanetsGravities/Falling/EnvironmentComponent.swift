//
//  FallingViewState.swift
//  StudyRealityKit
//
//  Created by Shayan on 4/27/24.
//

import Foundation
import RealityKit

struct EnvironmentComponent: Component {
    let state: EnvironmentState
}

class EnvironmentState: ObservableObject {
    
    @Published private(set) var falling: Falling = .configuring { didSet { print(falling) } }
    @Published var planet: Planet = .moon
    @Published var velocity: Float = 2
    @Published var remainingVelocityOnBounce: Float = 0.8
    
    func start() {
        if falling == .idle {
            falling = .performing
        }
    }
    
    func stop() {
        if falling == .performing {
            falling = .idle
        }
    }
    
    func makeItReady() {
        if falling == .configuring {
            falling = .idle
        }
    }
}

extension EnvironmentState {
    enum Falling {
        case configuring
        case idle
        case performing
    }
}
