//
//  SVGPath.swift
//  TappingSvgs
//
//  Created by William Tift on 02/06/25.
//

import Foundation

/**
 * Individual SVG paths with their actual IDs from the SVG file.
 * These IDs must exactly match the 'id' attributes in the SVG.
 */
enum SVGPath: String, CaseIterable {
    // Head consists of 3 separate paths
    case headPart1 = "Vector_head1"
    case headPart2 = "Vector_head2" 
    case headPart3 = "Vector_head3"
    
    // Chest is a single path
    case chest = "Vector_chest"
    
    // Left arm consists of 2 paths
    case leftArmUpper = "Vector_leftArm1"
    case leftArmLower = "Vector_leftArm2"
    
    // Right arm consists of 6 separate paths
    case rightArmPart1 = "Vector_rightArm1"
    case rightArmPart2 = "Vector_rightArm2"
    case rightArmPart3 = "Vector_rightArm3"
    case rightArmPart4 = "Vector_rightArm4"
    case rightArmPart5 = "Vector_rightArm5"
    case rightArmPart6 = "Vector_rightArm6"
    
    // Legs is currently a single path
    case legs = "Vector_legs"
    
    /// The actual ID string used in the SVG file
    var id: String {
        return self.rawValue
    }
} 