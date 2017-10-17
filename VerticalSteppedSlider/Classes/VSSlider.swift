//
//  VSSlider.swift
//  VerticalSteppedSlider
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
            slider.setValue(newValue, animated: true)
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
    
    @available(iOS 9.0, *)
    public override var semanticContentAttribute: UISemanticContentAttribute {
        set {
            super.semanticContentAttribute = newValue
            slider.semanticContentAttribute = newValue
            updateSlider()
        }
        get {
            return super.semanticContentAttribute
        }
    }

    
    public var roundedValue: Float {
        get {
            return slider.roundedValue
        }
    }
    
    private var lastDrawnSliderSize = CGSize.zero
    
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
        let layoutDirection: UIUserInterfaceLayoutDirection
        
        if #available(iOS 10.0, *) {
            layoutDirection = slider.effectiveUserInterfaceLayoutDirection
        } else if #available(iOS 9.0, *) {
            layoutDirection = UIView.userInterfaceLayoutDirection(for: slider.semanticContentAttribute)
        } else {
            layoutDirection = UIApplication.shared.userInterfaceLayoutDirection
        }
        
        switch (vertical, ascending, layoutDirection) {
        case (true, false, .leftToRight),
             (true, true, .rightToLeft):
            slider.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi) * -0.5)
        case (true, true, .leftToRight),
             (true, false, .rightToLeft):
            slider.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi) * 0.5).scaledBy(x: 1, y: -1)
        case (false, true, _):
            slider.transform = CGAffineTransform(scaleX: 1, y: -1)
        case (false, false, _):
            slider.transform = .identity
        }
        
        slider.minimumValue = minimumValue
        slider.maximumValue = maximumValue
        slider.isContinuous = isContinuous
        slider.increment = increment

        if let thumbImage = thumbImage {
            slider.setThumbImage(thumbImage, for: .normal)
        } else if let thumbTintColor = thumbTintColor {
            slider.thumbTintColor = thumbTintColor
        }
        
        updateTrackImage()
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
    
    public override func draw(_ rect: CGRect) {
        // Redraw track images if the slider size has changed
        if slider.bounds.size != lastDrawnSliderSize {
            lastDrawnSliderSize = slider.bounds.size
            updateTrackImage()
        }
        super.draw(rect)
    }
    
    // MARK: - Drawing methods
    
    private func updateTrackImage() {

        // Get slider dimensions
        let sliderBounds = slider.bounds
        let trackBounds = slider.trackRect(forBounds: sliderBounds)
        let thumbWidth = slider.thumbRect(forBounds: sliderBounds, trackRect: trackBounds, value: 0).size.width

        // We create an innerRect in which we paint the lines
        let innerRect = sliderBounds.insetBy(dx: 1.0, dy: (sliderBounds.height - trackWidth) / 2)

        // Get the range for drawing marks
        let range = getRangeForMarks()

        let minTrackColor = minimumTrackTintColor ?? tintColor ?? UIColor.blue
        let maxTrackColor = maximumTrackTintColor ?? UIColor.lightGray

        if let minimumSide = getTrackImage(innerRect: innerRect, thumbWidth: thumbWidth, range: range, trackColor: minTrackColor, trackImage: minimumTrackImage) {
            slider.setMinimumTrackImage(minimumSide, for: .normal)
        }
        if let maximumSide = getTrackImage(innerRect: innerRect, thumbWidth: thumbWidth, range: range, trackColor: maxTrackColor, trackImage: maximumTrackImage) {
            slider.setMaximumTrackImage(maximumSide, for: .normal)
        }
    }

    private func getTrackImage(innerRect: CGRect, thumbWidth: CGFloat, range: [Float], trackColor: UIColor, trackImage: UIImage?) -> UIImage? {
        UIGraphicsBeginImageContext(innerRect.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        let endOffset = trackExtendsUnderThumb ? 0 : thumbWidth

        var image: UIImage
        if let trackImage = trackImage {
            trackImage.draw(in: CGRect(x: endOffset / 2, y: (innerRect.height - trackWidth) / 2, width: innerRect.width - endOffset, height: trackWidth))
            image = UIGraphicsGetImageFromCurrentImageContext()!.resizableImage(withCapInsets: UIEdgeInsets.zero)
        } else {
            context.setLineCap(.round)
            context.setLineWidth(trackWidth)
            context.move(to: CGPoint(x: (trackWidth + endOffset) / 2, y: innerRect.height / 2))
            context.addLine(to: CGPoint(x: innerRect.size.width - (trackWidth + endOffset) / 2 - 2, y: innerRect.height / 2))
            context.setStrokeColor(trackColor.cgColor)
            context.strokePath()
            image = UIGraphicsGetImageFromCurrentImageContext()!.resizableImage(withCapInsets: UIEdgeInsets.zero)
        }

        // Set marks on selected side
        image.draw(at: CGPoint.zero)
        for value in range {
            let position = CGFloat((value - minimumValue) / (maximumValue - minimumValue)) * (innerRect.width - thumbWidth) + thumbWidth / 2
            context.setLineCap(.butt)
            context.setLineWidth(markWidth)
            context.move(to: CGPoint(x: position, y: innerRect.height / 2 - trackWidth / 2))
            context.addLine(to: CGPoint(x: position, y: innerRect.height / 2 + trackWidth / 2))
            context.setStrokeColor(markColor.cgColor)
            context.strokePath()
        }
        image = UIGraphicsGetImageFromCurrentImageContext()!.resizableImage(withCapInsets: UIEdgeInsets.zero)

        UIGraphicsEndImageContext()

        return image
    }

    private func getRangeForMarks() -> [Float] {
        if increment == 0 {
            return []
        }

        let minMark = minimumValue - minimumValue.truncatingRemainder(dividingBy: increment)
        var range = Array(stride(from: minMark, to: maximumValue, by: increment))

        if range.contains(minimumValue) {
            range.removeFirst()
        }

        return range
    }
}
