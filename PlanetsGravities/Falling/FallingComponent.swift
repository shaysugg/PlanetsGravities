//
//  FallingComponent.swift
//  StudyRealityKit
//
//  Created by Shayan on 4/27/24.
//

import Foundation
import RealityKit

class FallingComponent: Component {
    let initialVelocity: Float
    var velocity: Float
    var velocityReduceOnBounce: Float
    private(set) var startDate: Date?
  
    var started: Bool { startDate != nil }
    
    func start() {
        startDate = Date()
    }
    
    func bounced() {
        velocity = velocity * velocityReduceOnBounce
        start()
    }
    
    func stop() {
        startDate = nil
        velocity = initialVelocity
    }
    
    init(velocity: Float, velocityReduceOnBounce: Float) {
        self.initialVelocity = velocity
        self.velocity = velocity
        self.velocityReduceOnBounce = velocityReduceOnBounce
    }
}
