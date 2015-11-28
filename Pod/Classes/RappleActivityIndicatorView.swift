/* **
RappleActivityIndicatorView.swift
Custom Activity Indicator with swift 2.0

Created by Rajeev Prasad on 15/11/15.

The MIT License (MIT)

Copyright (c) 2015 Rajeev Prasad <rjeprasad@gmail.com>

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
- RappleTintColorKey            Color of the progrss circle and text
- RappleScreenBGColorKey        Background color (full screen background)
- RappleProgressBGColorKey      Background color around the progress indicator (Only applicable for Apple Style)
- RappleIndicatorStyleKey       Style of the ActivityIndicator
*/
public let RappleTintColorKey = "TintColorKet"
public let RappleScreenBGColorKey = "ScreenBGColorKey"
public let RappleProgressBGColorKey = "ProgressBGColorKey"
public let RappleIndicatorStyleKey = "IndicatorStyleKey"


/**
Available Styles
- RappleStyleApple              Default Apple ActivityIndicatr
- RappleStyleCircle             Custom Rapple Circle ActivityIndicator
*/
public let RappleStyleApple = "Apple"
public let RappleStyleCircle = "Circle"

/**
Preset Attribute dictionaries
- RappleClassicAttributes       Apple style ActivityIndicator
- RappleTintColorKey            UIColor.whiteColor()
- RappleScreenBGColorKey        UIColor(white: 0.0, alpha: 0.3)
- RappleProgressBGColorKey      UIColor(white: 0.0, alpha: 0.8)
- RappleIndicatorStyleKey       RappleStyleApple
*/
public let RappleAppleAttributes : [String:AnyObject] = [RappleTintColorKey:UIColor.whiteColor(), RappleIndicatorStyleKey:RappleStyleApple, RappleScreenBGColorKey:UIColor(white: 0.0, alpha: 0.3),RappleProgressBGColorKey:UIColor(white: 0.0, alpha: 0.8)]

/**
Preset Attribute dictionaries
- RappleModernAttributes        Apple style ActivityIndicator
- RappleTintColorKey            UIColor.whiteColor()
- RappleScreenBGColorKey        UIColor(white: 0.0, alpha: 0.5)
- RappleProgressBGColorKey      N/A
- RappleIndicatorStyleKey       RappleStyleApple
*/
public let RappleModernAttributes : [String:AnyObject] = [RappleTintColorKey:UIColor.whiteColor(), RappleIndicatorStyleKey:RappleStyleCircle, RappleScreenBGColorKey:UIColor(white: 0.0, alpha: 0.5)]


public class RappleActivityIndicatorView: NSObject {
    
    private static let sharedInstance = RappleActivityIndicatorView()
    
    private var backgroundView : UIView?
    private var text : String?
    
    private var attributes : [String:AnyObject] = RappleModernAttributes
    
    
    /**
     Start Rapple progress indicator without any text message
     attribute  default RappleModernAttributes
     */
    public class func startAnimating() {
        
        let keyWindow = UIApplication.sharedApplication().keyWindow
        keyWindow?.endEditing(true)
        keyWindow?.userInteractionEnabled = false
        
        let progress = RappleActivityIndicatorView.sharedInstance
        
        NSNotificationCenter.defaultCenter().addObserver(progress, selector: "topSecretMethod", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        progress.createProgress()
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            progress.backgroundView?.alpha = 1.0
            
            }) { (finished) -> Void in
                progress.createProgressIndicator()
        }
    }
    
    /**
     Start Rapple progress indicator with attributes and without any text message
     @param     attribute progress UI attributes
     */
    public class func startAnimating(attributes attributes:[String:AnyObject]) {
        RappleActivityIndicatorView.sharedInstance.attributes = attributes
        RappleActivityIndicatorView.startAnimating()
    }
    
    /**
     Start Rapple progress indicator with text message
     @param     label text for progress text label
     attribute  default RappleModernAttributes
     */
    public class func startAnimatingWithLabel(label : String) {
        RappleActivityIndicatorView.sharedInstance.text = label
        RappleActivityIndicatorView.startAnimating()
    }
    
    /**
     Start Rapple progress indicator with text message with attributes
     @param     label text for progress text label
     @param     attribute progress UI attributes
     */
    public class func startAnimatingWithLabel(label : String, attributes:[String:AnyObject]) {
        RappleActivityIndicatorView.sharedInstance.attributes = attributes
        RappleActivityIndicatorView.sharedInstance.text = label
        RappleActivityIndicatorView.startAnimating()
    }
    
    /**
     Stop Rapple progress indicator
     */
    public class func stopAnimating() {
        let keyWindow = UIApplication.sharedApplication().keyWindow
        keyWindow?.userInteractionEnabled = true
        
        let progress = RappleActivityIndicatorView.sharedInstance
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            progress.backgroundView?.alpha = 0.0
            keyWindow?.tintAdjustmentMode = .Automatic
            keyWindow?.tintColorDidChange()
            }) { (finished) -> Void in
                
                if let views = progress.backgroundView?.subviews {
                    for v in views {
                        v.removeFromSuperview()
                    }
                }
                
                progress.backgroundView?.removeFromSuperview()
                
                progress.backgroundView = nil
        }
        
        
        NSNotificationCenter.defaultCenter().removeObserver(progress)
    }
    
    private func createProgress() {
        let keyWindow = UIApplication.sharedApplication().keyWindow
        
        let size = keyWindow?.bounds.size
        let max = size?.width > size?.height ? size?.width : size?.height
        let bgRect = CGRectMake(0, 0, max!, max!)
        
        backgroundView = UIView(frame: bgRect)
        backgroundView?.backgroundColor = attributes[RappleScreenBGColorKey] as? UIColor
        backgroundView?.alpha = 1.0
        backgroundView?.userInteractionEnabled = false
        keyWindow?.addSubview(backgroundView!)
        
        
    }
    
    private func createProgressIndicator(){
        let keyWindow = UIApplication.sharedApplication().keyWindow
        
        let style = attributes[RappleIndicatorStyleKey] as? String
        
        if style != nil && style == RappleStyleApple {
            
            
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                
                let squre = UIView(frame: CGRectMake(0,0,150,100))
                squre.backgroundColor = self.attributes[RappleProgressBGColorKey] as? UIColor
                
                let indicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
                indicator.tintColor = self.attributes[RappleTintColorKey] as? UIColor
                indicator.center = CGPointMake(squre.center.x, squre.center.y-15)
                squre.addSubview(indicator)
                indicator.startAnimating()
                
                let label = UILabel(frame: CGRectMake(0, 0, (keyWindow?.bounds.size.width)! - 20, 21))
                label.center = CGPointMake(squre.center.x, squre.center.y + 20)
                label.textColor = self.attributes[RappleTintColorKey] as? UIColor
                label.textAlignment = .Center
                label.font = UIFont.boldSystemFontOfSize(16)
                label.text = self.text
                squre.addSubview(label)
                
                squre.layer.cornerRadius = 10.0
                squre.layer.masksToBounds = true
                squre.center = (keyWindow?.center)!
                
                self.backgroundView?.addSubview(squre)
            }
            
        } else {
            
            
            
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                
                let label = UILabel(frame: CGRectMake(0, 0, (keyWindow?.bounds.size.width)! - 20, 21))
                label.center = CGPointMake((keyWindow?.center.x)!, (keyWindow?.center.y)! + 40)
                label.textColor = self.attributes[RappleTintColorKey] as? UIColor
                label.textAlignment = .Center
                label.text = self.text
                self.backgroundView?.addSubview(label)
                
                self.addAnimatingCircle()
            }
        }
    }
    
    private func addAnimatingCircle() {
        let keyWindow = UIApplication.sharedApplication().keyWindow
        
        let circle = UIBezierPath(arcCenter: (keyWindow?.center)!, radius: 25.0, startAngle: 0.0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circle.CGPath
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor(white: 1.0, alpha: 0.8).CGColor
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
        
        shapeLayer.addAnimation(endGroup, forKey: "end")
        shapeLayer.addAnimation(startGroup, forKey: "start")
    }
    
}

extension RappleActivityIndicatorView {
    /**
     This is a top secret method
     */
    func topSecretMethod() {
        let progress = RappleActivityIndicatorView.sharedInstance
        if let views = progress.backgroundView?.subviews {
            for v in views {
                v.removeFromSuperview()
            }
        }
        progress.backgroundView?.removeFromSuperview()
        progress.backgroundView = nil
        
        progress.createProgress()
        progress.createProgressIndicator()
    }
}