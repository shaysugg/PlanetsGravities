//
//  EntityBuilders.swift
//  StudyRealityKit
//
//  Created by Shayan on 4/27/24.
//

import RealityKit
import UIKit

extension Entity {
    static func createBall() -> RealityKit.Entity {
        let mesh = MeshResource.generateSphere(radius: ballRadius)
        var material = SimpleMaterial()
        let image = try! TextureResource.load(named: "Basketball")
        material.color = .init(texture: .init(image))
        let model = ModelEntity(mesh: mesh, materials: [material])
        return model
    }
    
    static func createSurface(for planet: Planet) -> RealityKit.Entity {
        let mesh = MeshResource.generateBox(width: 0.3, height: surfaceHeight, depth: 0.3, cornerRadius: 0.1)
        var material = SimpleMaterial()
        let image = try! TextureResource.load(named: planet.name)
        material.color = .init(texture: .init(image))
        let model = ModelEntity(mesh: mesh, materials: [material])
        return model
    }
}

extension AnchorEntity {
    static func createHorizontalPlane() -> RealityKit.AnchorEntity {
        AnchorEntity(
            .plane(
                .horizontal,
                classification: .any,
                minimumBounds: SIMD2<Float>(0.2, 0.2)
            )
        )
    }
}
