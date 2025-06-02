//
//  BodyPart.swift
//  TappingSvgs
//
//  Created by William Tift on 02/06/25.
//

import Foundation

/**
 * Logical body parts that users interact with.
 * Each body part is composed of one or more SVG paths.
 */
enum BodyPart: String, CaseIterable {
    case head = "Head"
    case chest = "Chest" 
    case leftArm = "Left Arm"
    case rightArm = "Right Arm"
    case legs = "Legs"
    
    /**
     * Returns all SVG paths that compose this body part.
     */
    var svgPaths: [SVGPath] {
        switch self {
        case .head:
            return [.headPart1, .headPart2, .headPart3]
        case .chest:
            return [.chest]
        case .leftArm:
            return [.leftArmUpper, .leftArmLower]
        case .rightArm:
            return [.rightArmPart1, .rightArmPart2, .rightArmPart3, .rightArmPart4, .rightArmPart5, .rightArmPart6]
        case .legs:
            return [.legs]
        }
    }
    
    /**
     * Determines which body part contains a given SVG path.
     */
    init?(containingPath path: SVGPath) {
        for bodyPart in BodyPart.allCases {
            if bodyPart.svgPaths.contains(path) {
                self = bodyPart
                return
            }
        }
        return nil
    }
} 