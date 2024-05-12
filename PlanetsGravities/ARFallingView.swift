//
//  ARRealityKitView.swift
//  StudyRealityKit
//
//  Created by Shayan on 4/21/24.
//

import UIKit
import RealityKit
import ARKit
import Combine


class ARFallingView: ARView {
    
    let state: EnvironmentState
    
    init(state: EnvironmentState) {
        self.state = state
        super.init(frame: .zero)
        session.delegate = self
    }
    
    required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required dynamic init(frame frameRect: CGRect) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let ball = Entity.createBall()
        ball.components[FallingComponent.self] = FallingComponent(velocity: state.velocity, velocityReduceOnBounce: state.remainingVelocityOnBounce)
        ball.components[EnvironmentComponent.self] = EnvironmentComponent(state: state)
        ball.transform.translation.y = initialBallPosition
        
        let surface = Entity.createSurface(for: state.planet)
        surface.components[SurfaceComponent.self] = SurfaceComponent(planet: state.planet)
        surface.components[EnvironmentComponent.self] = EnvironmentComponent(state: state)
        
        let anchor = AnchorEntity.createHorizontalPlane()
        anchor.addChild(ball)
        anchor.addChild(surface)
        scene.addAnchor(anchor)
    }
}


extension Scene {
    static private let query = EntityQuery(where: .has(FallingComponent.self) && .has(EnvironmentComponent.self))
    
    var fallingEntities: QueryResult<Entity> { performQuery(Self.query) }
}


extension ARFallingView: ARSessionDelegate {
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let anchor = anchor as? ARPlaneAnchor, anchor.alignment == .horizontal {
                state.makeItReady()
            }
        }
    }
}
