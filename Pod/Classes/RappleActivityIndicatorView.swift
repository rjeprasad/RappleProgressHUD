/* **
 RappleActivityIndicatorView.swift
 Custom Activity Indicator with swift 4
 
 Created by Rajeev Prasad on 15/11/15.
 
 The MIT License (MIT)
 
 Copyright (c) 2017 Rajeev Prasad <rjeprasad@gmail.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 ** */

import UIKit

/**
 Rapple progress attribute dictionary keys
 - RappleTintColorKey               Color of the progrss circle and text
 - RappleScreenBGColorKey           Background color (full screen background)
 - RappleProgressBGColorKey         Background color around the progress indicator (Only applicable for Apple Style)
 - RappleIndicatorStyleKey          Style of the ActivityIndicator
 - RappleIndicatorThicknessKey      Thickness(width) of the progress indicator(if applicable) and completion indicator
 - RappleProgressBarColorKey        Progress bar bg color
 - RappleProgressBarFillColorKey    Progress bar filling color with progression
 */
public let RappleTintColorKey               = "TintColorKey"
public let RappleScreenBGColorKey           = "ScreenBGColorKey"
public let RappleProgressBGColorKey         = "ProgressBGColorKey"
public let RappleIndicatorStyleKey          = "IndicatorStyleKey"
public let RappleIndicatorThicknessKey      = "IndicatorThicknessKey"
public let RappleProgressBarColorKey        = "ProgressBarColorKey"
public let RappleProgressBarFillColorKey    = "ProgressBarFillColorKey"


/**
 Available Styles
 - RappleStyleApple             Default Apple ActivityIndicator
 - RappleStyleCircle            Custom Rapple Circle ActivityIndicator
 - RappleStyleText              Custom Rapple Text based indicator (e.g. Please wait...)
 */
public let RappleStyleApple     = "Apple"
public let RappleStyleCircle    = "Circle"
public let RappleStyleText      = "Text"

public enum RappleStyle: String {
    case apple = "Apple"
    case circle = "Circle"
    case text = "Text"
}

/**
 Progress completion with status
 - none             Stop and hide animation with out completion indicator
 - success          ✓ symbol
 - failed           ✕ symbol
 - incomplete       ! symbol
 - unknown          ? symbol
 */
public enum RappleCompletion: String {
    case none // default value (no completion indicator)
    case success
    case failed
    case incomplete
    case unknown
}

/**
 Predefined attribute dictionary to match default apple look & feel
 - RappleIndicatorStyleKey          RappleStyleApple
 - RappleTintColorKey               UIColor.whiteColor()
 - RappleScreenBGColorKey           UIColor(white: 0.0, alpha: 0.2)
 - RappleProgressBGColorKey         UIColor(white: 0.0, alpha: 0.7)
 - RappleProgressBarColorKey        lightGray
 - RappleProgressBarFillColorKey    white
 - RappleIndicatorThicknessKey      4.0
 */
public let RappleAppleAttributes : [String:Any] = [RappleTintColorKey:UIColor.white, RappleIndicatorStyleKey:RappleStyleApple, RappleScreenBGColorKey:UIColor(white: 0.0, alpha: 0.2),RappleProgressBGColorKey:UIColor(white: 0.0, alpha: 0.7), RappleProgressBarColorKey: UIColor.lightGray, RappleProgressBarFillColorKey: UIColor.white]

/**
 Predefined attribute dictionary to match modern look & feel
 - RappleIndicatorStyleKey          RappleStyleCircle
 - RappleTintColorKey               UIColor.whiteColor()
 - RappleScreenBGColorKey           UIColor(white: 0.0, alpha: 0.5)
 - RappleProgressBGColorKey         N/A
 - RappleProgressBarColorKey        lightGray
 - RappleProgressBarFillColorKey    white
 - RappleIndicatorThicknessKey      4.0
 */
public let RappleModernAttributes : [String:Any] = [RappleTintColorKey:UIColor.white, RappleIndicatorStyleKey:RappleStyleCircle, RappleScreenBGColorKey:UIColor(white: 0.0, alpha: 0.5), RappleProgressBarColorKey: UIColor.lightGray, RappleProgressBarFillColorKey: UIColor.white]


/**
 Predefined attribute dictionary to match texual progress indicator
 - RappleIndicatorStyleKey          RappleStyleText
 - RappleTintColorKey               UIColor.whiteColor()
 - RappleScreenBGColorKey           UIColor(white: 0.0, alpha: 0.5)
 - RappleProgressBGColorKey         N/A
 - RappleProgressBarColorKey        N/A
 - RappleProgressBarFillColorKey    N/A
 - RappleIndicatorThicknessKey      4.0
 */
public let RappleTextAttributes : [String:Any] = [RappleTintColorKey:UIColor.white, RappleIndicatorStyleKey:RappleStyleText, RappleScreenBGColorKey:UIColor(white: 0.0, alpha: 0.5)]

/**
 RappleActivityIndicatorView is a shared controller and calling multipel times will overide the previouse activity indicator view.
 So closing it once at the end of process will close shared activity indicator completely
 */
extension RappleActivityIndicatorView {
    
    /**
     Create custom attribute dictionary
     - parameter style: Style of the ActivityIndicator 'enum RappleStyle'
     - parameter tintColor: Color of the progrss circle and text
     - parameter screenBG: Background color (full screen background)
     - parameter progressBG: Background color around the progress indicator (Only applicable for Apple Style)
     - parameter progressBarBG: Progress bar bg color
     - parameter progreeBarFill: Progress bar filling color with progression
     */
    public class func attribute(style: RappleStyle = .circle,
                                tintColor: UIColor = UIColor.white,
                                screenBG: UIColor = UIColor(white: 0.0, alpha: 0.5),
                                progressBG: UIColor = UIColor(white: 0.0, alpha: 0.8),
                                progressBarBG: UIColor = UIColor.lightGray,
                                progreeBarFill: UIColor = UIColor.white,
                                thickness: CGFloat = 4.0) -> [String: Any] {
        
        var attribute: [String: Any] = [RappleIndicatorStyleKey: style.rawValue]
        attribute[RappleTintColorKey] = tintColor
        attribute[RappleScreenBGColorKey] = screenBG
        attribute[RappleProgressBGColorKey] = progressBG
        attribute[RappleProgressBarColorKey] = progressBarBG
        attribute[RappleProgressBarFillColorKey] = progreeBarFill
        attribute[RappleIndicatorThicknessKey] = thickness
        
        return attribute;
        
    }
    
    /**
     Start Rapple progress indicator without any text message, using RappleModernAttributes
     */
    @objc public class func startAnimating() {
        DispatchQueue.main.async {
            RappleActivityIndicatorView.localClearUp()
            RappleActivityIndicatorView.startPrivateAnimating()
        }
    }
    
    /**
     Start Rapple progress indicator without any text message
     - parameter attributes: dictionary with custom attributes
     */
    @objc public class func startAnimating(attributes:[String:Any]) {
        DispatchQueue.main.async {
            RappleActivityIndicatorView.localClearUp()
            RappleActivityIndicatorView.startPrivateAnimating(attributes: attributes)
        }
    }
    
    /**
     Start Rapple progress indicator & text message, using RappleModernAttributes
     - parameter label: text value to display with activity indicator
     */
    @objc public class func startAnimatingWithLabel(_ label : String) {
        DispatchQueue.main.async {
            RappleActivityIndicatorView.localClearUp()
            RappleActivityIndicatorView.startPrivateAnimatingWithLabel(label)
        }
    }
    
    /**
     Start Rapple progress indicator & text message
     - parameter label: text value to display with activity indicator
     - parameter attributes: dictionary with custom attributes
     */
    @objc public class func startAnimatingWithLabel(_ label : String, attributes:[String:Any]) {
        DispatchQueue.main.async {
            RappleActivityIndicatorView.localClearUp()
            RappleActivityIndicatorView.startPrivateAnimatingWithLabel(label, attributes: attributes)
        }
    }
    
    /**
     Start Rapple progress value indicator
     - parameter progress: progress amount 0<= x <= 1.0
     - parameter textValue: texual progress amount value (e.g. "3/8" or "3 of 10") - only limited space avaibale
     - Note: textValue -> nil for percentage value (e.g. 78%)
     - Note: textValue -> "" to hide texual progress amount
     - Note: normal progress bar will display for 'RappleStyleApple' and circular progress bar will display for 'RappleStyleCircle'
     */
    @objc public class func setProgress(_ progress: CGFloat, textValue: String? = nil) {
        DispatchQueue.main.async {
            RappleActivityIndicatorView.setPrivateProgress(Float(progress), textValue: textValue)
        }
    }
    
    /**
     Start Rapple progress value indicator
     - parameter showCompletion: show completion indicator Default false
     - parameter completionLabel: string label for completion indicator Default nil
     - parameter completionTimeout: hide completion indicator after timeout time Defailt = 2.0
     */
    @objc @available(*, deprecated, message: "use `stopAnimation(completionIndicator: completionLabel: completionTimeout:)` instead (this method will be removed from v3.0)")
    public class func stopAnimating(showCompletion: Bool = false, completionLabel: String? = nil, completionTimeout: TimeInterval = 2.0) {
        DispatchQueue.main.async {
            if showCompletion == true {
                RappleActivityIndicatorView.stopPrivateAnimating(indicator: .success, completionLabel: completionLabel, completionTimeout: completionTimeout)
            } else {
                RappleActivityIndicatorView.stopPrivateAnimating(indicator:.none, completionLabel: completionLabel, completionTimeout: completionTimeout)
            }
        }
    }
    
    /**
     Start Rapple progress value indicator
     - parameter completionIndicator: completion indicator type - Default: RappleCompletionNone (no indicator)
     - parameter completionLabel: string label for completion indicator Default nil
     - parameter completionTimeout: hide completion indicator after timeout time Defailt = 2.0
     */
    public class func stopAnimation(completionIndicator: RappleCompletion = .none, completionLabel: String? = nil, completionTimeout: TimeInterval = 2.0) {
        DispatchQueue.main.async {
            RappleActivityIndicatorView.stopPrivateAnimating(indicator: completionIndicator, completionLabel: completionLabel, completionTimeout: completionTimeout)
        }
    }
    
    /** Check wheather RappleActivityIndicatorView is visible */
    @objc public class func isVisible() -> Bool {
        return RappleActivityIndicatorView.isPrivateVisible()
    }
    
    /** Cleanup text & attribute values*/
    private class func localClearUp() {
        RappleActivityIndicatorView.sharedInstance.textLabel = nil
        RappleActivityIndicatorView.sharedInstance.attributes.removeAll()
    }
}

/**
 RappleActivityIndicatorView is a shared controller and calling multipel times will overide the previouse activity indicator view.
 So closing it once at the end of process will close shared activity indicator completely
 */
open class RappleActivityIndicatorView: NSObject {
    
    /**
     Shared instance for internal usage
     */
    @objc static let sharedInstance = RappleActivityIndicatorView()
    
    @objc var backgroundView : UIView? // full screen background
    @objc var contentSqure : UIView? // background atounf progress (apple style)
    
    @objc var activityIndicator : UIActivityIndicatorView? // apple activity indicator
    @objc var circularActivity1 : CAShapeLayer? // circular activity indicator
    @objc var circularActivity2 : CAShapeLayer? // circular activity indicator
    @objc var completionPoint : CGPoint = .zero // activity indicator center point
    @objc var completionRadius : CGFloat = 18 // activity indicator complete circle
    @objc var completionWidth : CGFloat = 4 // activity indicator complete circle
    
    @objc var progressBar : UIProgressView? // apple style bar
    @objc var progressLayer : CAShapeLayer? // circular bar
    @objc var progressLayerBG : CAShapeLayer? // circular bar
    @objc var progressLabel : UILabel? // percentage value
    @objc var activityLable : UILabel? // text value
    @objc var completionLabel : UILabel? // completion indicator
    
    @objc var textStyleVisible: Bool = false // texual progress
    
    @objc var textLabel : String?
    @objc var attributes : [String:Any] = RappleModernAttributes
    @objc var currentProgress: Float = 0
    @objc var showProgress: Bool = false
    
    @objc var dotCount: Int = 0 // texual progress dot count
    
    /** set attribute dictionary */
    @objc func setAttributeDict(attributes: [String:Any]) {
        RappleActivityIndicatorView.sharedInstance.attributes = attributes
        self.attributes[RappleIndicatorStyleKey] = style
    }
    
    /** get current style */
    @objc var style: String {
        if let st = RappleActivityIndicatorView.sharedInstance.attributes[RappleIndicatorStyleKey] as? String {
            if st == RappleStyleApple {
                return RappleStyleApple
            } else if st == RappleStyleText {
                return RappleStyleText
            }
        }
        return RappleStyleCircle
    }
    
    /** radius of the circular activity indicator */
    @objc var radius: CGFloat {
        if showProgress {
            return 40
        } else {
            return 26
        }
    }
    
}
