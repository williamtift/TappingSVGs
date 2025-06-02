//
//  ContentView.swift
//  TappingSvgs
//
//  Created by William Tift on 19/5/23.
//

import SwiftUI
import SVGView

/**
 * ContentView demonstrates how to group multiple SVG paths into logical body parts
 * and detect which body part was tapped when any of its component paths are touched.
 */
struct ContentView: View {
    /// Currently selected body part - drives visual feedback
    @State private var selectedPart: BodyPart?
    
    var body: some View {
        // Load the SVG file from app bundle
        let svgView = SVGView(contentsOf: Bundle.main.url(forResource: "character", withExtension: "svg")!)
        
        // Configure interaction for each SVG path
        setupSVGInteractions(for: svgView)
        
        return svgView
            .padding()
    }
    
    /**
     * Sets up tap gestures and visual feedback for all SVG paths.
     */
    private func setupSVGInteractions(for svgView: SVGView) {
        // For each SVG path we want to make interactive
        SVGPath.allCases.forEach { svgPath in
            // Get the actual SVG node (path) by its ID and determine which body part it belongs to
            if let pathNode = svgView.getNode(byId: svgPath.id),
               let bodyPart = BodyPart(containingPath: svgPath) {
                
                // Add tap gesture to this path
                pathNode.onTapGesture {
                    selectedPart = bodyPart
                    print("Tapped \(svgPath.id) - belongs to \(String(describing: bodyPart))")
                }
                
                // Apply visual styling if this path's body part is selected
                applyVisualFeedback(to: pathNode, for: bodyPart)
            }
        }
    }
    
    /**
     * Changes the appearance of SVG paths when their body part is selected.
     */
    private func applyVisualFeedback(to pathNode: SVGNode, for bodyPart: BodyPart) {
        guard let shape = pathNode as? SVGShape,
              bodyPart == selectedPart else { return }
        
        // Change fill color to red when selected
        shape.fill = SVGColor.by(name: "red")
        
        // Add black stroke for emphasis
        if let strokeColor = SVGColor.by(name: "black") {
            shape.stroke = SVGStroke(fill: strokeColor, width: 2)
        }
        
        // Alternative: Modify opacity instead of color
        // shape.opacity = 0.5
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
