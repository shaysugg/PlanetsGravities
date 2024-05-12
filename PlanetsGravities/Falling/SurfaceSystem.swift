//
//  SurfaceSystem.swift
//  StudyRealityKit
//
//  Created by Shayan on 4/30/24.
//

import Foundation
import RealityKit

class SurfaceSystem: System {
    
    static let query = EntityQuery(where: .has(SurfaceComponent.self) && .has(EnvironmentComponent.self))
    
    required init(scene: Scene) {
    }
    
    func update(context: SceneUpdateContext) {
        let entities = context.scene.performQuery(Self.query)
        for entity in entities {
            let environmentComponent = entity.component(withType: EnvironmentComponent.self)
            let surfaceComponent = entity.component(withType: SurfaceComponent.self)
            
            //change surface material if environment has changed
            if surfaceComponent.planet.name != environmentComponent.state.planet.name {
                let planet = environmentComponent.state.planet
                entity.components.set(SurfaceComponent(planet: planet))
                if let image = try? TextureResource.load(named: planet.name), let entity = entity as? ModelEntity {
                    var material = SimpleMaterial()
                    material.color = SimpleMaterial.BaseColor(texture: .init(image))
                    entity.model?.materials = [material]
                }
            }
        }
    }
    
}
