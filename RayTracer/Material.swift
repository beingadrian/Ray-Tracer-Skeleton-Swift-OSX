//
// Ray caster/tracer skeleton code and scene files adapted from starter code
// provided by MIT 6.837 on OCW.
//
// All additional code written by Dion Larson unless noted otherwise.
//
// Original skeleton code available for free here (assignments 4 & 5):
// http://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-837-computer-graphics-fall-2012/
//
// Licensed under Creative Commons 4.0 (Attribution, Noncommercial, Share Alike)
// http://creativecommons.org/licenses/by-nc-sa/4.0/
//

import Foundation
import simd

class Material {
    
    private let diffuseColor: vector_float3
    private let specularColor: vector_float3
    private let shininess: Float
    private var texture: Texture?
    var hasTexture: Bool {
        return texture != nil
    }

    init(diffuseColor: vector_float3, specularColor: vector_float3, shininess: Float, textureName: String?) {
        self.diffuseColor = diffuseColor
        self.specularColor = specularColor
        self.shininess = shininess
        if let textureName = textureName {
            self.texture = Texture(filename: textureName)
        }
    }
    
    func setupTexture(textureFilename: String) {
        texture = Texture(filename: textureFilename)
    }
    
    func shade(ray: Ray, hit: Hit, lightInfo light: (direction: vector_float3, color: vector_float3)) -> vector_float3 {
        
        // diffuseCoefficient = diffuseColor
        
        guard let hitNormal = hit.normal else { return vector_float3() }
        
        let influence = max(0, dot(hitNormal, light.direction))
        
        guard (influence > 0) else { return vector_float3() }
        
        var shadedColor = diffuseColor * influence * light.color
        
        // specular calculation here
        
        let reflectedLight = -light.direction + 2 * influence * hitNormal
        let R = max(dot(-ray.direction, reflectedLight), 0) ** shininess
        shadedColor += specularColor * R * light.color
        
        return shadedColor
        
    }
    
    func getDiffuseColor() -> vector_float3 {
        return self.diffuseColor
    }
    
}