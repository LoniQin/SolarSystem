//
//  GameController.swift
//  SolarSystem Shared
//
//  Created by Lonnie on 2025/2/10.
//

import SceneKit

#if os(macOS)
    typealias SCNColor = NSColor
#else
    typealias SCNColor = UIColor
#endif

@MainActor
class GameController: NSObject, SCNSceneRendererDelegate {
    
    let scene: SCNScene
    let sceneRenderer: SCNSceneRenderer
    
    init(sceneRenderer renderer: SCNSceneRenderer) {
        sceneRenderer = renderer
        scene = SCNScene()
        
        super.init()
        
        sceneRenderer.delegate = self
        
        setupSolarSystem()
        
        sceneRenderer.scene = scene
    }
    
    private func setupSolarSystem() {
        // Create the Sun
        let sunGeometry = SCNSphere(radius: 1.5)
        sunGeometry.firstMaterial?.diffuse.contents = SCNColor.yellow
        sunGeometry.firstMaterial?.emission.contents = SCNColor.yellow
        let sunNode = SCNNode(geometry: sunGeometry)
        scene.rootNode.addChildNode(sunNode)
        
        // Add sunlight
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.light?.color = SCNColor(white: 1.0, alpha: 1.0)
        sunNode.addChildNode(lightNode)
        
        // Setup camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 25, z: 50)
        cameraNode.look(at: sunNode.position)
        scene.rootNode.addChildNode(cameraNode)
        
        // Add ambient light
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = SCNColor(white: 0.3, alpha: 1.0)
        scene.rootNode.addChildNode(ambientLightNode)
        
        // Planet data structure
        struct Planet {
            let name: String
            let radius: CGFloat
            let distance: CGFloat
            let color: SCNColor
            let orbitalPeriod: TimeInterval
            let rotationPeriod: TimeInterval
        }
        
        // Planet configurations
        let planets: [Planet] = [
            Planet(name: "Mercury", radius: 0.4, distance: 6, color: .gray, orbitalPeriod: 5, rotationPeriod: 3),
            Planet(name: "Venus", radius: 0.6, distance: 9, color: .orange, orbitalPeriod: 8, rotationPeriod: 4),
            Planet(name: "Earth", radius: 0.7, distance: 12, color: .blue, orbitalPeriod: 12, rotationPeriod: 1),
            Planet(name: "Mars", radius: 0.5, distance: 15, color: .red, orbitalPeriod: 16, rotationPeriod: 1.5),
            Planet(name: "Jupiter", radius: 1.4, distance: 20, color: .brown, orbitalPeriod: 20, rotationPeriod: 0.5),
            Planet(name: "Saturn", radius: 1.2, distance: 25, color: .yellow, orbitalPeriod: 24, rotationPeriod: 0.6),
            Planet(name: "Uranus", radius: 1.0, distance: 30, color: .cyan, orbitalPeriod: 28, rotationPeriod: 0.7),
            Planet(name: "Neptune", radius: 1.0, distance: 35, color: .blue, orbitalPeriod: 32, rotationPeriod: 0.8),
            Planet(name: "Pluto", radius: 0.3, distance: 40, color: .darkGray, orbitalPeriod: 36, rotationPeriod: 5)
        ]
        
        // Create planets
        for planet in planets {
            let orbitNode = SCNNode()
            scene.rootNode.addChildNode(orbitNode)
            
            let planetNode = SCNNode()
            planetNode.geometry = SCNSphere(radius: planet.radius)
            planetNode.geometry?.firstMaterial?.diffuse.contents = planet.color
            planetNode.position = SCNVector3(planet.distance, 0, 0)
            orbitNode.addChildNode(planetNode)
            
            // Orbital animation
            let orbitAction = SCNAction.rotateBy(x: 0, y: .pi * 2, z: 0, duration: planet.orbitalPeriod)
            orbitNode.runAction(.repeatForever(orbitAction))
            
            // Rotation animation
            let rotationAction = SCNAction.rotateBy(x: 0, y: .pi * 2, z: 0, duration: planet.rotationPeriod)
            planetNode.runAction(.repeatForever(rotationAction))
        }
    }
    
    func highlightNodes(atPoint point: CGPoint) {
        let hitResults = sceneRenderer.hitTest(point, options: [:])
        for result in hitResults {
            guard let material = result.node.geometry?.firstMaterial else { continue }
            
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                material.emission.contents = SCNColor.black
                SCNTransaction.commit()
            }
            material.emission.contents = SCNColor.red
            SCNTransaction.commit()
        }
    }
    
    nonisolated func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        // Update logic if needed
    }
}
