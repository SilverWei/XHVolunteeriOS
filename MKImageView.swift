//
//  MKImageView.swift
//  MaterialKit
//
//  Created by Le Van Nghia on 11/29/14.
//  Copyright (c) 2014 Le Van Nghia. All rights reserved.
//

import UIKit

@IBDesignable
public class MKImageView: UIImageView
{
    @IBInspectable public var maskEnabled: Bool = true {
        didSet {
            mkLayer.enableMask(enable: maskEnabled)
        }
    }
    @IBInspectable public var rippleLocation: MKRippleLocation = .TapLocation {
        didSet {
            mkLayer.rippleLocation = rippleLocation
        }
    }
    @IBInspectable public var aniDuration: Float = 0.65
    @IBInspectable public var rippleAniTimingFunction: MKTimingFunction = .Linear
    @IBInspectable public var backgroundAniTimingFunction: MKTimingFunction = .Linear
    @IBInspectable public var backgroundAniEnabled: Bool = true {
        didSet {
            if !backgroundAniEnabled {
                mkLayer.enableOnlyCircleLayer()
            }
        }
    }
    @IBInspectable public var ripplePercent: Float = 0.9 {
        didSet {
            mkLayer.ripplePercent = ripplePercent
        }
    }

    @IBInspectable public var cornerRadius: CGFloat = 2.5 {
        didSet {
            layer.cornerRadius = cornerRadius
            mkLayer.setMaskLayerCornerRadius(cornerRadius)
        }
    }
    // color
    @IBInspectable public var rippleLayerColor: UIColor = UIColor(white: 0.45, alpha: 0.5) {
        didSet {
            mkLayer.setCircleLayerColor(rippleLayerColor)
        }
    }
    @IBInspectable public var backgroundLayerColor: UIColor = UIColor(white: 0.75, alpha: 0.25) {
        didSet {
            mkLayer.setBackgroundLayerColor(backgroundLayerColor)
        }
    }
    override public var bounds: CGRect {
        didSet {
            mkLayer.superLayerDidResize()
        }
    }
    private lazy var mkLayer: MKLayer = MKLayer(superLayer: self.layer)



    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    override public init(image: UIImage!) {
        super.init(image: image)
        setup()
    }

    override public init(image: UIImage!, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        setup()
    }

    private func setup() {
        mkLayer.setCircleLayerColor(rippleLayerColor)
        mkLayer.setBackgroundLayerColor(backgroundLayerColor)
        mkLayer.setMaskLayerCornerRadius(cornerRadius)
    }

    public func animateRipple(location: CGPoint? = nil) {
        if let point = location {
            mkLayer.didChangeTapLocation(point)
        } else if rippleLocation == .TapLocation {
            rippleLocation = .Center
        }

        mkLayer.animateScaleForCircleLayer(0.65, toScale: 1.0, timingFunction: rippleAniTimingFunction, duration: CFTimeInterval(aniDuration))
        mkLayer.animateAlphaForBackgroundLayer(backgroundAniTimingFunction, duration: CFTimeInterval(aniDuration))
    }


}
