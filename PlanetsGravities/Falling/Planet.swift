//
//  Planet.swift
//  StudyRealityKit
//
//  Created by Shayan on 4/27/24.
//

import Foundation

struct Planet {
    let gravityAcceleration: Float
    let name: String
}

extension Planet {
    static var mercury: Planet {
        Planet(gravityAcceleration: 3.7, name: "Mercury")
    }
    
    static var venus: Planet {
        Planet(gravityAcceleration: 8.87, name: "Venus")
    }
    
    static var earth: Planet {
        Planet(gravityAcceleration: 9.81, name: "Earth")
    }
    
    static var moon: Planet {
        Planet(gravityAcceleration: 1.625, name: "Moon")
    }
    
    static var mars: Planet {
        Planet(gravityAcceleration: 3.71, name: "Mars")
    }
    
    static var jupiter: Planet {
        Planet(gravityAcceleration: 24.79, name: "Jupiter")
    }
    
    static var saturan: Planet {
        Planet(gravityAcceleration: 10.44, name: "Saturan")
    }
    
    static var uranus: Planet {
        Planet(gravityAcceleration: 8.69, name: "Uranus")
    }
    
    static var neptune: Planet {
        Planet(gravityAcceleration: 11.15, name: "Neptune")
    }
    
    static var all: [Planet] { [.mercury, .venus, .moon, .earth, .mars, .jupiter, .saturan, .uranus, .neptune] }
}
