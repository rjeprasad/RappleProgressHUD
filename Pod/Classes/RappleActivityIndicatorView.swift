/* **
 RappleActivityIndicatorView.swift
 Custom Activity Indicator with swift 2.0
 
 Created by Rajeev Prasad on 15/11/15.
 
 The MIT License (MIT)
 
 Copyright (c) 2016 Rajeev Prasad <rjeprasad@gmail.com>
 
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
 - RappleProgressBarColorKey        Progress bar bg color
 - RappleProgressBarFillColorKey    Progress bar filling color with progression
 */
public let RappleTintColorKey               = "TintColorKey"
public let RappleScreenBGColorKey           = "ScreenBGColorKey"
public let RappleProgressBGColorKey         = "ProgressBGColorKey"
public let RappleIndicatorStyleKey          = "IndicatorStyleKey"
public let RappleProgressBarColorKey        = "ProgressBarColorKey"
public let RappleProgressBarFillColorKey    = "ProgressBarFillColorKey"


/**
 Available Styles
 - RappleStyleApple              Default Apple ActivityIndicator
 - RappleStyleCircle             Custom Rapple Circle ActivityIndicator
 */
public let RappleStyleApple     = "Apple"
public let RappleStyleCircle    = "Circle"

/**
 Predefined attribute dictionary to match default apple look & feel
 - RappleTintColorKey               UIColor.whiteColor()
 - RappleScreenBGColorKey           UIColor(white: 0.0, alpha: 0.2)
 - RappleProgressBGColorKey         UIColor(white: 0.0, alpha: 0.7)
 - RappleIndicatorStyleKey          RappleStyleApple
 - RappleProgressBarColorKey        lightGray
 - RappleProgressBarFillColorKey    white
 */
public let RappleAppleAttributes : [String:AnyObject] = [RappleTintColorKey:UIColor.white, RappleIndicatorStyleKey:RappleStyleApple as AnyObject, RappleScreenBGColorKey:UIColor(white: 0.0, alpha: 0.2),RappleProgressBGColorKey:UIColor(white: 0.0, alpha: 0.7), RappleProgressBarColorKey: UIColor.lightGray, RappleProgressBarFillColorKey: UIColor.white]

/**
 Predefined attribute dictionary to match modern look & feel
 - RappleTintColorKey               UIColor.whiteColor()
 - RappleScreenBGColorKey           UIColor(white: 0.0, alpha: 0.5)
 - RappleProgressBGColorKey         N/A
 - RappleIndicatorStyleKey          RappleStyleCircle
 - RappleProgressBarColorKey        lightGray
 - RappleProgressBarFillColorKey    white
 */
public let RappleModernAttributes : [String:AnyObject] = [RappleTintColorKey:UIColor.white, RappleIndicatorStyleKey:RappleStyleCircle as AnyObject, RappleScreenBGColorKey:UIColor(white: 0.0, alpha: 0.5), RappleProgressBarColorKey: UIColor.lightGray, RappleProgressBarFillColorKey: UIColor.white]

/**
 RappleActivityIndicatorView is a shared controller and calling multipel times will overide the previouse activity indicator view.
 So closing it once at the end of process will close shared activity indicator completely
 */
extension RappleActivityIndicatorView {
    
    /**
     Start Rapple progress indicator without any text message, using RappleModernAttributes
     */
    public class func startAnimating() {
        DispatchQueue.main.async {
            RappleActivityIndicatorView.startPrivateAnimating()
        }
    }
    
    /**
     Start Rapple progress indicator without any text message
     @param attributes  - dictionary with custom attributes
     */
    public class func startAnimating(attributes:[String:AnyObject]) {
        DispatchQueue.main.async {
            RappleActivityIndicatorView.startPrivateAnimating(attributes: attributes)
        }
    }
    
    /**
     Start Rapple progress indicator & text message, using RappleModernAttributes
     @param label       - text value to display with activity indicator
     */
    public class func startAnimatingWithLabel(_ label : String) {
        DispatchQueue.main.async {
            RappleActivityIndicatorView.startPrivateAnimatingWithLabel(label)
        }
    }
    
    /**
     Start Rapple progress indicator & text message
     @param label       - text value to display with activity indicator
     @param attributes  - dictionary with custom attributes
     */
    public class func startAnimatingWithLabel(_ label : String, attributes:[String:AnyObject]) {
        DispatchQueue.main.async {
            RappleActivityIndicatorView.startPrivateAnimatingWithLabel(label, attributes: attributes)
        }
    }
    
    /**
     Start Rapple progress value indicator
     @param progress    - progress amount 0<= x <= 1.0
     @param textValue   - texual progress amount value (e.g. "3/8" or "3 of 10") - only limited space avaibale
     @note textValue    - send nil for percentage value (e.g. 78%)
     @note textValue    - send "" to hide texual progress amount
     Progress bar will display for 'RappleStyleApple' style
     Progress percentage value will display for 'RappleStyleCircle' style
     */
    public class func setProgress(_ progress: CGFloat, textValue: String? = nil) {
        DispatchQueue.main.async {
            RappleActivityIndicatorView.setPrivateProgress(Float(progress), textValue: textValue)
        }
    }
    
    /** Stop Rapple progress indicator */
    public class func stopAnimating() {
        DispatchQueue.main.async {
            RappleActivityIndicatorView.stopPrivateAnimating()
        }
    }
    
    /** Check wheather RappleActivityIndicatorView is visible */
    public class func isVisible() -> Bool {
        return RappleActivityIndicatorView.isPrivateVisible()
    }
}

/**
 RappleActivityIndicatorView is a shared controller and calling multipel times will overide the previouse activity indicator view.
 So closing it once at the end of process will close shared activity indicator completely
 */
open class RappleActivityIndicatorView: NSObject {
    
    fileprivate static let sharedInstance = RappleActivityIndicatorView()
    
    fileprivate var backgroundView : UIView?
    fileprivate var contentView : UIView?
    fileprivate var progressBar : UIProgressView?
    fileprivate var progressLayer : CAShapeLayer?
    fileprivate var progressLabel : UILabel?
    
    fileprivate var text : String?
    fileprivate var attributes : [String:AnyObject] = RappleModernAttributes
    fileprivate var currentProgress: Float = 0
    fileprivate var showProgress: Bool = false
    
    /** isVisible */
    fileprivate class func isPrivateVisible() -> Bool {
        let progress = RappleActivityIndicatorView.sharedInstance
        return progress.backgroundView?.superview != nil
    }
    
    /** create & start */
    fileprivate class func startPrivateAnimating() {
        
        sharedInstance.keyWindow.endEditing(true)
        sharedInstance.keyWindow.isUserInteractionEnabled = false
        
        let progress = RappleActivityIndicatorView.sharedInstance
        
        NotificationCenter.default.addObserver(progress, selector: #selector(RappleActivityIndicatorView.orientationChanged), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        sharedInstance.showProgress = false
        
        progress.createProgressBG()
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            progress.backgroundView?.alpha = 1.0
            
            }, completion: { (finished) -> Void in
                progress.createActivityIndicator()
        })
    }
    
    /** create & start */
    fileprivate class func startPrivateAnimating(attributes:[String:AnyObject]) {
        RappleActivityIndicatorView.sharedInstance.attributes = attributes
        RappleActivityIndicatorView.startAnimating()
    }
    
    /** create & start */
    fileprivate class func startPrivateAnimatingWithLabel(_ label : String) {
        RappleActivityIndicatorView.sharedInstance.text = label
        RappleActivityIndicatorView.startAnimating()
    }
    
    /** create & start */
    fileprivate class func startPrivateAnimatingWithLabel(_ label : String, attributes:[String:AnyObject]) {
        RappleActivityIndicatorView.sharedInstance.attributes = attributes
        RappleActivityIndicatorView.sharedInstance.text = label
        RappleActivityIndicatorView.startAnimating()
    }
    
    /** stop & clear */
    fileprivate class func stopPrivateAnimating() {
        sharedInstance.keyWindow.isUserInteractionEnabled = true
        
        let progress = RappleActivityIndicatorView.sharedInstance
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            progress.backgroundView?.alpha = 0.0
            sharedInstance.keyWindow.tintAdjustmentMode = .automatic
            sharedInstance.keyWindow.tintColorDidChange()
            }, completion: { (finished) -> Void in
                
                if let views = progress.backgroundView?.subviews {
                    for v in views {
                        v.removeFromSuperview()
                    }
                }
                
                progress.backgroundView?.removeFromSuperview()
                
                progress.backgroundView = nil
        })
        NotificationCenter.default.removeObserver(progress)
    }
    
    /** set progress values */
    fileprivate class func setPrivateProgress(_ progress: Float, textValue: String? = nil) {
        if progress >= 0 && progress <= 1.0 {
            sharedInstance.currentProgress = progress
            if sharedInstance.showProgress == false {
                sharedInstance.showProgress = true
                sharedInstance.createActivityIndicator()
            }
            
            let style = sharedInstance.attributes[RappleIndicatorStyleKey] as? String ?? RappleStyleCircle
            if style == RappleStyleApple {
                sharedInstance.setBarProgressValue(progress, pgText: textValue)
            } else {
                sharedInstance.addProgresCircle(progress, pgText: textValue)
            }
            
        } else {
            print("Error RappleActivityIndicatorView: Invalid progress value")
        }
    }
    
    /** create background view */
    fileprivate func createProgressBG() {
        if (backgroundView == nil){
            backgroundView = UIView(frame: CGRect.zero)
            backgroundView?.translatesAutoresizingMaskIntoConstraints = false
            backgroundView?.backgroundColor = getColor(key: RappleScreenBGColorKey)
            backgroundView?.alpha = 1.0
            backgroundView?.isUserInteractionEnabled = false
            keyWindow.addSubview(backgroundView!)
            
            let dic = ["BG": backgroundView!]
            keyWindow.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[BG]|", options: .alignAllCenterY, metrics: nil, views: dic))
            keyWindow.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[BG]|", options: .alignAllCenterX, metrics: nil, views: dic))
        }
    }
    
    /** create all UIs */
    fileprivate func createActivityIndicator(){
        if backgroundView == nil { createProgressBG() }
        clearUIs() // clear all before restart
        let style = attributes[RappleIndicatorStyleKey] as? String ?? RappleStyleCircle
        if style != nil && style == RappleStyleApple {
            createAppleUIs()
        } else {
            createCircleUIs()
        }
    }
    
    /** create Apple style UIs */
    fileprivate func createAppleUIs() {
        var sqWidth: CGFloat = 45
        // calc center values
        let size = calcTextSize(text)
        let h = 45 + size.height
        var sqHeight: CGFloat = h + 20
        let cd = 24 + size.height - (h / 2)
        var c = keyWindow.center; c.y -= cd
        
        // add activity indicator
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.color = getColor(key: RappleTintColorKey)
        indicator.startAnimating()
        backgroundView?.addSubview(indicator)
        if showProgress == false {
            indicator.center = c
            sqWidth = size.width + 20
        } else {
            var newc = c; newc.x -= 100
            indicator.center = newc
            sqWidth = 260
            
            progressBar = UIProgressView(progressViewStyle: .bar)
            progressBar?.frame = CGRect(x: 0, y: 0, width: 180, height: 4)
            progressBar?.center = CGPoint(x: c.x + 22, y: newc.y)
            progressBar?.trackTintColor = getColor(key: RappleProgressBarColorKey)
            progressBar?.progressTintColor = getColor(key: RappleProgressBarFillColorKey)
            backgroundView?.addSubview(progressBar!)
            
            createProgressBarValueDisplay("25%")
        }
        
        // add label and size
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: size.width+1, height: size.height+1))
        let x = keyWindow.center.x
        let y = keyWindow.center.y - (size.height / 2) + (h / 2)
        label.center = CGPoint(x: x, y: y)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = getColor(key: RappleTintColorKey)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = text
        backgroundView?.addSubview(label)
        
        // set the rounded rectangle view at the middle
        let squre = UIView(frame: CGRect(x: 0, y: 0, width: sqWidth, height: sqHeight))
        squre.backgroundColor = getColor(key: RappleProgressBGColorKey)
        squre.layer.cornerRadius = 10.0
        squre.layer.masksToBounds = true
        squre.center = keyWindow.center
        backgroundView?.addSubview(squre)
        
        backgroundView?.sendSubview(toBack: squre)
    }
    
    fileprivate func setBarProgressValue(_ progress: Float, pgText: String?){
        progressBar?.progress = progress
        var textVal = pgText
        if pgText == nil {
            textVal = "\(Int(progress * 100))%";
        }
        progressLabel?.text = textVal
    }
    
    /** create & set progress text value label */
    fileprivate func createProgressBarValueDisplay(_ pgText: String?) {
        if progressLabel == nil {
            var c = progressBar!.center
            c.y += 10; progressBar?.center = c
            var rect = progressBar!.frame
            rect.origin.y -= 24
            rect.size.height = 21
            progressLabel = UILabel(frame: rect)
            progressLabel?.textColor = getColor(key: RappleTintColorKey)
            progressLabel?.textAlignment = .right
            backgroundView?.addSubview(progressLabel!)
        }
        progressLabel?.text = pgText
    }
    
    /** create circular UIs */
    fileprivate func createCircleUIs() {
        let size = calcTextSize(text)
        let yi = addAnimatingCircle(twoSided: showProgress == false)
        if showProgress == true {
            addProgresCircle(currentProgress, pgText: "")
        }
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: size.width+1, height: size.height+1))
        let x = keyWindow.center.x
        let y = yi + (size.height / 2)
        label.center = CGPoint(x: x, y: y)
        label.textColor = getColor(key: RappleTintColorKey)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = text
        backgroundView?.addSubview(label)
    }
    
    /** radius of the circular activity indicator */
    fileprivate var radius: CGFloat {
        if showProgress {
            return 40
        } else {
            return 26
        }
    }
    
    /** calc text value height - max 220x x 100 */
    fileprivate func calcTextSize(_ text: String?) -> CGSize {
        if (text == nil) {
            return CGSize.zero
        }
        let size = (text as! NSString).boundingRect(with: CGSize(width: 220, height: 9999), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)], context: nil).size
        var h = size.height
        if h > 100 {
            h = 100
        }
        var w = size.width
        if w > 220 {
            w = 220
        }
        return CGSize(width: w, height: h)
    }
    
    /** create circulat activity indicators */
    fileprivate func addAnimatingCircle(twoSided: Bool) -> CGFloat {
        
        let size = calcTextSize(text)
        let r = radius
        let h = (2 * r) + size.height + 10
        let cd = (h - size.height - 10) / 2
        
        var center = keyWindow.center; center.y -= cd
        
        let circle1 = UIBezierPath(arcCenter: center, radius: r, startAngle: CGFloat(-M_PI_2), endAngle:CGFloat(3 * M_PI_2), clockwise: true)
        rotatingCircle(circle: circle1)
        
        if twoSided == true {
            let circle2 = UIBezierPath(arcCenter: center, radius: r, startAngle: CGFloat(M_PI_2), endAngle:CGFloat(5 * M_PI_2), clockwise: true)
            rotatingCircle(circle: circle2)
        }
        
        return center.y + r + 10
    }
    
    /** create circular path with UIBezierPath */
    fileprivate func rotatingCircle(circle: UIBezierPath) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circle.cgPath
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = getColor(key: RappleTintColorKey).cgColor
        shapeLayer.lineWidth = 5.0
        backgroundView?.layer.addSublayer(shapeLayer)
        
        let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        strokeEnd.fromValue = 0.0
        strokeEnd.toValue = 1.0
        strokeEnd.duration = 1.0
        strokeEnd.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let endGroup = CAAnimationGroup()
        endGroup.duration = 1.3
        endGroup.repeatCount = MAXFLOAT
        endGroup.animations = [strokeEnd]
        
        let strokeStart = CABasicAnimation(keyPath: "strokeStart")
        strokeStart.beginTime = 0.3
        strokeStart.fromValue = 0.0
        strokeStart.toValue = 1.0
        strokeStart.duration = 1.0
        strokeStart.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let startGroup = CAAnimationGroup()
        startGroup.duration = 1.3
        startGroup.repeatCount = MAXFLOAT
        startGroup.animations = [strokeStart]
        
        shapeLayer.add(endGroup, forKey: "end")
        shapeLayer.add(startGroup, forKey: "start")
    }
    
    /** create & set circular progress bar */
    fileprivate func addProgresCircle(_ progress: Float, pgText: String?) {
        
        if progressLayer == nil {
            let size = calcTextSize(text)
            let r = radius
            let h = 2 * r + size.height + 10
            let cd = (h - size.height - 10) / 2
            
            var center = keyWindow.center; center.y -= cd
            let circle = UIBezierPath(arcCenter: center, radius: (r - 5), startAngle: CGFloat(-M_PI_2), endAngle:CGFloat(2 * M_PI - M_PI_2), clockwise: true)
            
            let pgrsBg = CAShapeLayer()
            pgrsBg.path = circle.cgPath
            pgrsBg.fillColor = nil
            pgrsBg.strokeColor = getColor(key: RappleProgressBarColorKey).cgColor
            pgrsBg.lineWidth = 4.0
            backgroundView?.layer.addSublayer(pgrsBg)
            
            progressLayer = CAShapeLayer()
            progressLayer?.path = circle.cgPath
            progressLayer?.fillColor = nil
            progressLayer?.strokeColor = getColor(key: RappleProgressBarFillColorKey).cgColor
            progressLayer?.lineWidth = 4.0
            backgroundView?.layer.addSublayer(progressLayer!)
            
            createProgressCircleValueDisplay("", center: center, radius: r)
        }
        var textVal = pgText
        if pgText == nil { textVal = "\(Int(progress * 100))%"; }
        progressLabel?.text = textVal
        
        progressLayer?.strokeStart = 0.0
        progressLayer?.strokeEnd = CGFloat(progress)
    }
    
    /** create & set progress text value label */
    fileprivate func createProgressCircleValueDisplay(_ pgText: String?, center: CGPoint, radius: CGFloat) {
        if progressLabel == nil {
            let w = (radius * 2) - 10
            progressLabel = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: w))
            progressLabel?.center = center
            progressLabel?.textColor = getColor(key: RappleTintColorKey)
            progressLabel?.textAlignment = .center
            progressLabel?.numberOfLines = 0
            progressLabel?.lineBreakMode = .byWordWrapping
            backgroundView?.addSubview(progressLabel!)
        }
    }
}

extension RappleActivityIndicatorView {
    /** get color attribute values for key */
    fileprivate func getColor(key: String) -> UIColor {
        if let color = attributes[key] as? UIColor {
            return color
        }
        switch key {
        case RappleTintColorKey:
            return UIColor.white.withAlphaComponent(0.8)
        case RappleScreenBGColorKey:
            return UIColor.black.withAlphaComponent(0.4)
        case RappleProgressBGColorKey:
            return UIColor.black.withAlphaComponent(0.7)
        case RappleProgressBarColorKey:
            return UIColor.black.withAlphaComponent(0.9)
        case RappleProgressBarFillColorKey:
            return UIColor.white.withAlphaComponent(0.9)
        default:
            return UIColor.white.withAlphaComponent(0.8)
        }
    }
    /** re-create after orientation change */
    internal func orientationChanged() {
        RappleActivityIndicatorView.sharedInstance.createActivityIndicator()
    }
    /** clear all UIs */
    fileprivate func clearUIs() {
        if let bgview = RappleActivityIndicatorView.sharedInstance.backgroundView {
            for v in bgview.subviews {
                v.removeFromSuperview()
            }
            if let layers = bgview.layer.sublayers {
                for l in layers {
                    l.removeFromSuperlayer()
                }
            }
            progressLayer = nil;
            progressLabel = nil;
        }
    }
    
    /** get key window */
    fileprivate var keyWindow: UIWindow {
        return UIApplication.shared.keyWindow!
    }
}
