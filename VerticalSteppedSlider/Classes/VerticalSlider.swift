//
//  VerticalSlider.swift
//  SliderTest
//
//  Created by Melissa Ludowise on 8/24/17.
//  Copyright © 2017 Mel Ludowise. All rights reserved.
//

import UIKit

@IBDesignable
public class VSSlider: UIControl {
    
    private let slider = InternalSlider()

    @IBInspectable
    public var vertical: Bool = true {
        didSet {
            updateSlider()
        }
    }
    
    @IBInspectable
    public var ascending: Bool = false {
        didSet {
            updateSlider()
        }
    }
    
    @IBInspectable
    public var value: Float {
        get {
            return slider.value
        }
        set {
            slider.setValue(value, animated: true)
        }
    }
    
    @IBInspectable
    public var minimumValue: Float = 0 {
        didSet {
            updateSlider()
        }
    }
    
    @IBInspectable
    public var maximumValue: Float = 1 {
        didSet {
            updateSlider()
        }
    }
    
    @IBInspectable
    public var increment: Float = 0.5 {
        didSet {
            updateSlider()
        }
    }
    
    @IBInspectable
    public var trackWidth: CGFloat = 2 {
        didSet {
            updateSlider()
        }
    }
    
    @IBInspectable
    public var markWidth: CGFloat = 1 {
        didSet {
            updateSlider()
        }
    }
    
    @IBInspectable
    public var markColor: UIColor = UIColor.darkGray {
        didSet {
            updateSlider()
        }
    }
    
    @IBInspectable
    public var minimumTrackTintColor: UIColor? {
        didSet {
            updateSlider()
        }
    }
    
    @IBInspectable open var maximumTrackTintColor: UIColor? {
        didSet {
            updateSlider()
        }
    }
    
    @IBInspectable
    public var thumbTintColor: UIColor? {
        didSet {
            updateSlider()
        }
    }
    
    @IBInspectable
    public var minimumTrackImage: UIImage? {
        didSet {
            updateSlider()
        }
    }
    
    @IBInspectable
    public var maximumTrackImage: UIImage? {
        didSet {
            updateSlider()
        }
    }
    
    @IBInspectable
    public var thumbImage: UIImage? {
        didSet {
            updateSlider()
        }
    }
    
    @IBInspectable
    public var trackExtendsUnderThumb: Bool = true {
        didSet {
            updateSlider()
        }
    }
    
    @IBInspectable
    public var isContinuous: Bool = true {
        didSet {
            updateSlider()
        }
    }
    
    override public var isEnabled: Bool {
        set {
            super.isEnabled = newValue
            slider.isEnabled = newValue
        }
        get {
            return super.isEnabled
        }
    }
    
    public var roundedValue: Float {
        get {
            return slider.roundedValue
        }
    }
    
    // required for IBDesignable class to properly render
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialize()
    }
    
    // required for IBDesignable class to properly render
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    fileprivate func initialize() {
        updateSlider()
        addSubview(slider)
    }
    
    fileprivate func updateSlider() {
        switch (vertical, ascending) {
        case (true, false):
            slider.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi) * -0.5)
        case (true, true):
            slider.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi) * 0.5).scaledBy(x: 1, y: -1)
        case (false, true):
            slider.transform = CGAffineTransform(scaleX: 1, y: -1)
        case (false, false):
            slider.transform = .identity
        }
        
        slider.value = value
        slider.minimumValue = minimumValue
        slider.maximumValue = maximumValue
        slider.isContinuous = isContinuous
        slider.increment = increment
        slider.trackWidth = trackWidth
        slider.markWidth = markWidth
        slider.markColor = markColor
        slider.trackExtendsUnderThumb = trackExtendsUnderThumb
        
        if let minimumTrackImage = minimumTrackImage {
            slider.setMinimumTrackImage(minimumTrackImage, for: .normal)
        } else if let minimumTrackTintColor = minimumTrackTintColor {
            slider.minimumTrackTintColor = minimumTrackTintColor
        }

        if let maximumTrackImage = maximumTrackImage {
            slider.setMaximumTrackImage(maximumTrackImage, for: .normal)
        } else if let maximumTrackTintColor = maximumTrackTintColor {
            slider.maximumTrackTintColor = maximumTrackTintColor
        }

        if let thumbImage = thumbImage {
            slider.setThumbImage(thumbImage, for: .normal)
        } else if let thumbTintColor = thumbTintColor {
            slider.thumbTintColor = thumbTintColor
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if vertical {
            slider.bounds.size.width = bounds.height
        } else {
            slider.bounds.size.width = bounds.width
        }
        slider.center.x = bounds.midX
        slider.center.y = bounds.midY
    }
    
    override open var intrinsicContentSize: CGSize {
        get {
            if vertical {
                return CGSize(width: slider.intrinsicContentSize.height, height: slider.intrinsicContentSize.width)
            } else {
                return slider.intrinsicContentSize
            }
        }
    }
    
    override public func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControlEvents) {
        slider.addTarget(target, action: action, for: controlEvents)
    }
}
