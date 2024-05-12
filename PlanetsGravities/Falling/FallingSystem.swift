//
//  FallingSystem.swift
//  StudyRealityKit
//
//  Created by Shayan on 4/27/24.
//

import RealityKit
import Combine
import Foundation

struct FallingSystem: System {
    
    init(scene: Scene) {}
    
    func update(context: SceneUpdateContext) {
        
        for entity in context.scene.fallingEntities {
            startMovementIfNeeded(for: entity)
            stopMovementIfNeeded(for: entity)
            movement(for: entity)
        }
    }
    
    private func movement(for entity: Entity) {
        let fallingComponent = entity.component(withType: FallingComponent.self)
        let environmentComponent = entity.component(withType: EnvironmentComponent.self)
        
        guard let startDate = fallingComponent.startDate, fallingComponent.started else { return }
        
        let deltaTime = abs(Float(Date.now.distance(to: startDate)))
        let sqrtTime = pow(deltaTime,2)
        let gravity: Float = environmentComponent.state.planet.gravityAcceleration
        
        let distance = 0.5 * -gravity * sqrtTime + fallingComponent.velocity * deltaTime + initialBallPosition
        
        entity.transform.translation.y = distance
        
        if entity.transform.translation.y <= initialBallPosition {
            fallingComponent.bounced()
            return
        }
        
        print(fallingComponent.velocity)
        if fallingComponent.velocity < 0.1 {
            fallingComponent.stop()
            environmentComponent.state.stop()
            return
        }
         
    }
    
    private func startMovementIfNeeded(for entity: Entity) {
        let fallingComponent = entity.component(withType: FallingComponent.self)
        let environmentComponent = entity.component(withType: EnvironmentComponent.self)
        
        if environmentComponent.state.falling == .performing && !fallingComponent.started {
            fallingComponent.velocity = environmentComponent.state.velocity
            fallingComponent.velocityReduceOnBounce = environmentComponent.state.remainingVelocityOnBounce
            fallingComponent.start()
        }
    }
    
    private func stopMovementIfNeeded(for entity: Entity) {
        let fallingComponent = entity.component(withType: FallingComponent.self)
        let environmentComponent = entity.component(withType: EnvironmentComponent.self)
        
        if environmentComponent.state.falling == .idle && fallingComponent.started {
            fallingComponent.stop()
            entity.transform.translation.y = initialBallPosition
        }
    }
}
