//
//  ContentView.swift
//  TappingSvgs
//
//  Created by William Tift on 19/5/23.
//

import SwiftUI
import SVGView

struct ContentView: View {
    @State private var selectedPart: BodyPart?
    
    var body: some View {
        let view = SVGView(contentsOf: Bundle.main.url(forResource: "character", withExtension: "svg")!)
        BodyPart.Vector.allCases.forEach { vector in
            if let part = view.getNode(byId: vector.rawValue) {
                
                let correspondingBodyPart = BodyPart.init(path: vector)
                
                part.onTapGesture {
                    selectedPart = correspondingBodyPart
                }
                
//                part.opacity = correspondingBodyPart == selectedPart ? 0.2 : 1
                if let shape = (part as? SVGShape), correspondingBodyPart == selectedPart {
                    shape.fill =  SVGColor.by(name: "red")
                    if let color = SVGColor.by(name: "black") {
                        shape.stroke = SVGStroke(fill: color, width: 2)
                    }
                }
                
            }
        }
        return view
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum BodyPart: CaseIterable {
    case head, chest, leftArm, rightArm, legs
    
    enum Vector: String, CaseIterable {
        case a = "Vector"
        case b = "Vector_2"
        case c = "Vector_3"
        case d = "Vector_4"
        case e = "Vector_5"
        case f = "Vector_6"
        case g = "Vector_7"
        case h = "Vector_8"
        case i = "Vector_9"
        case j = "Vector_10"
        case k = "Vector_11"
        case l = "left"
    }
    
    var paths: [Vector] {
        switch self {
        case .legs: return [.a]
        case .leftArm: return [.b, .l]
        case .rightArm: return [.g, .h, .i, .j, .k]
        case .chest: return [.c]
        case .head: return [.d, .e, .f]
        }
    }
    
    init?(path: Vector) {
        if BodyPart.legs.paths.contains(path) {
            self = .legs
        } else if BodyPart.leftArm.paths.contains(path) {
            self = .leftArm
        } else if BodyPart.rightArm.paths.contains(path) {
            self = .rightArm
        } else if BodyPart.chest.paths.contains(path) {
            self = .chest
        } else if BodyPart.head.paths.contains(path) {
            self = .head
        } else {
            return nil
        }
    }
}
