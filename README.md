# TappingSVGs

A SwiftUI iOS sample project that demonstrates how to detect taps on individual layers within an SVG file and provide visual feedback. This shows a practical approach to making SVG elements interactive in SwiftUI apps.

## What This Sample Shows

This project demonstrates a specific technique: **grouping multiple SVG paths into logical body parts** and **detecting which body part was tapped** when a user interacts with any of its component paths.

### The Core Problem

SVG files contain individual `<path>` elements with unique IDs, but users think in terms of logical groups. For example:

- The **right arm** in our character SVG is actually composed of 6 separate paths (`Vector_rightArm1` through `Vector_rightArm6`)
- When someone taps *any* part of the right arm, we want to detect that they tapped "the right arm" as a whole
- We want to highlight the *entire* right arm, not just the individual path that was touched

### Body Part Composition

Our character SVG maps like this:

- **Head** = 3 paths (`Vector_head1`, `Vector_head2`, `Vector_head3`)
- **Left Arm** = 2 paths (`Vector_leftArm1`, `Vector_leftArm2`) 
- **Right Arm** = 6 paths (`Vector_rightArm1` through `Vector_rightArm6`)
- **Chest** = 1 path (`Vector_chest`)
- **Legs** = 1 path (`Vector_legs`)

## How It Works

### 1. Path-to-BodyPart Mapping
```swift
enum BodyPart {
    case head, chest, leftArm, rightArm, legs
    
    var svgPaths: [SVGPath] {
        switch self {
        case .rightArm: 
            return [.rightArmPart1, .rightArmPart2, .rightArmPart3, 
                    .rightArmPart4, .rightArmPart5, .rightArmPart6]
        // ... other mappings
        }
    }
}
```

### 2. Tap Detection
```swift
// For each SVG path, set up tap detection
if let pathNode = svgView.getNode(byId: svgPath.id) {
    let bodyPart = BodyPart(containingPath: svgPath)
    
    pathNode.onTapGesture {
        selectedPart = bodyPart  // Select the whole body part
    }
}
```

### 3. Visual Feedback
When a body part is selected, all paths belonging to that body part get highlighted:
```swift
// Apply red fill and black stroke to selected parts
shape.fill = SVGColor.by(name: "red")
shape.stroke = SVGStroke(fill: blackColor, width: 2)
```

## Project Structure

```
TappingSvgs/
├── ContentView.swift          # Main view and interaction logic
├── BodyPart.swift            # Logical grouping of SVG paths into body parts
├── SVGPath.swift             # Individual SVG path definitions with their IDs
├── character.svg             # Sample SVG with 11 interactive paths
└── TappingSvgsApp.swift      # App entry point
```

## Key Implementation Details

**SVGPath enum**: Maps to actual SVG path IDs from the file
```swift
enum SVGPath: String {
    case rightArmPart1 = "Vector_rightArm1"  // Must match SVG exactly
    case rightArmPart2 = "Vector_rightArm2"
    // ...
}
```

**BodyPart enum**: Defines logical groupings and reverse lookup
```swift
init?(containingPath path: SVGPath) {
    // Determines which body part contains a given path
}
```

## Customizing for Your SVG

To adapt this approach to your own SVG:

1. **Identify your SVG path IDs**: Look for `<path id="..." />` elements
2. **Update the SVGPath enum**: Match the `rawValue` strings to your actual IDs
3. **Define your logical groups**: Map paths to whatever makes sense for your use case
4. **Adjust granularity as needed**: Split or merge SVG paths based on desired interaction level

### Example: Separate Left/Right Legs

Currently our character has one `Vector_legs` path. To detect left vs right leg separately:
- Modify your SVG to have separate `<path id="Vector_leftLeg">` and `<path id="Vector_rightLeg">` elements
- Update the body parts enum to reflect the separate groupings to which we want to associate the new paths:
```swift
enum BodyPart {
    case leftLeg, rightLeg  // Instead of just 'legs'
}
```

## Dependencies

This project uses [SVGView](https://github.com/exyte/SVGView) (1.0+) to render SVG files and make individual paths interactive. See their documentation for more details on SVG capabilities.

## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift Package Manager

## Installation

1. Clone this repository
2. Open `TappingSvgs.xcodeproj` in Xcode  
3. Build and run

The SVGView dependency is already configured via Swift Package Manager.

## Usage

Tap different parts of the character to see how individual SVG paths are grouped into body parts and highlighted as units.

---

**Created May 2023** - Sample project demonstrating SVG layer interaction in SwiftUI. 

**Polished June 2025**