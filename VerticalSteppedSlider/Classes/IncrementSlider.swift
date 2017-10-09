//
//  IncrementSlider.swift
//  SliderTest
//
//  Created by Melissa Ludowise on 8/24/17.
//  Copyright © 2017 Mel Ludowise. All rights reserved.
//

import UIKit

class InternalSlider: UISlider {

    var increment: Float = 0
    var trackWidth: CGFloat = 2
    var markWidth: CGFloat = 1
    var markColor: UIColor = UIColor.darkGray
    
    var thumbImage: UIImage? {
        didSet {
            setThumbImage(thumbImage, for: .normal)
        }
    }
    
    var roundedValue: Float {
        get {
            return round(super.value, to: increment)
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.frame.size = self.intrinsicContentSize
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        addTarget(self, action: #selector(endSliding), for: .touchUpInside)
        addTarget(self, action: #selector(endSliding), for: .touchUpOutside)
    }
    
    @objc private func endSliding() {
        setValue(round(super.value, to: increment), animated: true)
        sendActions(for: .valueChanged)
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // We create an innerRect in which we paint the lines
        var innerRect = rect.insetBy(dx: 1.0, dy: (rect.height - trackWidth) / 2)
        UIGraphicsBeginImageContextWithOptions(innerRect.size, false, 0)
        var context = UIGraphicsGetCurrentContext()!
        
        // Get the range for drawing marks
        var range = getRangeForMarks()
        
        // Minimum side
        var minimumSide = UIImage()
        if let minimumTrackTintColor = minimumTrackTintColor {
            context.setLineCap(.round)
            context.setLineWidth(trackWidth)
            context.move(to: CGPoint(x: trackWidth / 2, y: innerRect.height / 2))
            context.addLine(to: CGPoint(x: innerRect.size.width - trackWidth / 2 - 2, y: innerRect.height / 2))
            context.setStrokeColor(minimumTrackTintColor.cgColor)
            context.strokePath()
            minimumSide = UIGraphicsGetImageFromCurrentImageContext()!.resizableImage(withCapInsets: UIEdgeInsets.zero)
        } else if let currentMinimumTrackImage = currentMinimumTrackImage {
            currentMinimumTrackImage.draw(in: CGRect(x: 0, y: (innerRect.height - trackWidth) / 2, width: innerRect.width, height: trackWidth))
            minimumSide = UIGraphicsGetImageFromCurrentImageContext()!.resizableImage(withCapInsets: UIEdgeInsets.zero)
        }
        
        // Maximum side
        var maximumSide = UIImage()
        if let maximumTrackTintColor = maximumTrackTintColor  {
            context.setLineCap(.round)
            context.setLineWidth(trackWidth)
            context.move(to: CGPoint(x: trackWidth / 2, y: innerRect.height / 2))
            context.addLine(to: CGPoint(x: innerRect.size.width - trackWidth / 2 - 2, y: innerRect.height / 2))
            context.setStrokeColor(maximumTrackTintColor.cgColor)
            context.strokePath()
            maximumSide = UIGraphicsGetImageFromCurrentImageContext()!.resizableImage(withCapInsets: UIEdgeInsets.zero)
        } else if let currentMaximumTrackImage = currentMaximumTrackImage {
            currentMaximumTrackImage.draw(in: CGRect(x: 0, y: (innerRect.height - trackWidth) / 2, width: innerRect.width, height: trackWidth))
            maximumSide = UIGraphicsGetImageFromCurrentImageContext()!.resizableImage(withCapInsets: UIEdgeInsets.zero)
        }
        
        if increment != 0 {
            // Set marks on selected side
            minimumSide.draw(at: CGPoint.zero)
            for value in range {
                let position = CGFloat((value - minimumValue) / (maximumValue - minimumValue)) * innerRect.width
                context.setLineCap(.butt)
                context.setLineWidth(markWidth)
                context.move(to: CGPoint(x: position, y: innerRect.height / 2 - trackWidth / 2))
                context.addLine(to: CGPoint(x: position, y: innerRect.height / 2 + trackWidth / 2))
                context.setStrokeColor(markColor.cgColor)
                context.strokePath()
            }
            minimumSide = UIGraphicsGetImageFromCurrentImageContext()!.resizableImage(withCapInsets: UIEdgeInsets.zero)
            
            // Set marks on unselected side
            maximumSide.draw(at: CGPoint.zero)
            for value in range {
                let position = CGFloat((value - minimumValue) / (maximumValue - minimumValue)) * innerRect.width
                context.setLineCap(.butt)
                context.setLineWidth(markWidth)
                context.move(to: CGPoint(x: position, y: innerRect.height / 2 - trackWidth / 2))
                context.addLine(to: CGPoint(x: position, y: innerRect.height / 2 + trackWidth / 2))
                context.setStrokeColor(markColor.cgColor)
                context.strokePath()
            }
            maximumSide = UIGraphicsGetImageFromCurrentImageContext()!.resizableImage(withCapInsets: UIEdgeInsets.zero)
        }

        func UIGraphicsEndImageContext() {
            setMinimumTrackImage(minimumSide, for: .normal)
            setMaximumTrackImage(maximumSide, for: .normal)
        }
        
        UIGraphicsEndImageContext()
    }
    
    private func getRangeForMarks() -> [Float] {
        let minMark = minimumValue - minimumValue.truncatingRemainder(dividingBy: increment)
        var range = Array(stride(from: minMark, to: maximumValue, by: increment))
        
        if range.contains(minimumValue) {
            range.removeFirst()
        }
        
        return range
    }
}

fileprivate func round(_ value: Float, to increment: Float) -> Float {
    if increment == 0 {
        return value
    }
    return increment * Float(round(value / increment))
}
