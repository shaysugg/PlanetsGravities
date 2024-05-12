//
//  Helpers.swift
//  StudyRealityKit
//
//  Created by Shayan on 5/11/24.
//

import RealityKit

extension Entity {
    func component<C>(withType type: C.Type) -> C where C: Component {
        self.components[C.self] as! C
    }
}
