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

protocol Camera {
    func generateRay(point point: vector_float2) -> Ray
    var tMin: Float { get }
    var center: vector_float3 { get }
    var direction: vector_float3 { get }
    var up: vector_float3 { get }
    var horizontal: vector_float3 { get }
}

class PerspectiveCamera : Camera {
    
    /**
     * The center coordinate of the camera.
     */
    internal let center: vector_float3
    /**
     * The direction of the camera.
     */
    internal let direction: vector_float3
    /**
     * The upward direction of the camera.
     */
    internal let up: vector_float3
    /**
     * Y-axis of the camera.
     * Cross product of Y-vector and Z-vector.
     */
    internal let horizontal: vector_float3
    /**
     * The minimum time. 
     */
    internal let tMin: Float = 0
    /**
     * The field ov view in radians.
     */
    internal let fieldOfView: Float
    /**
     * The aspect ratio of the camera.
     */
    internal let aspect: Float

    init(center: vector_float3, direction: vector_float3, up: vector_float3, fieldOfView: Float, w: Int, h: Int) {
        
        self.center = center
        self.direction = normalize(direction)
        
        self.horizontal = normalize(cross(direction, up))
            
        self.up = normalize(cross(horizontal, direction))
        self.fieldOfView = fieldOfView
        self.aspect = Float(h / w)
        
    }
    
    /**
     * Generates a ray between the center of the camera to a
     * point on the normalized 2D plane.
     *
     * - parameter point: A point on the normalized 2D plane.
     * - returns: A ray.
     */
    func generateRay(point point: vector_float2) -> Ray {
        
        let distance = 1 / tan(self.fieldOfView / 2)
        
        let direction: vector_float3 = (point.x * self.horizontal) + (self.aspect * point.y * self.up) + (distance * self.direction)
        
        return Ray(origin: self.center, direction: normalize(direction))
    }
}