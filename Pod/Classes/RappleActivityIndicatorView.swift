//
//  RappleActivityIndicatorView.swift
//  Pods
//
//  Created by Rajeev Prasad on 15/11/15.
//
//

import UIKit

/**
RappleActivityIndicatorView - Custom Activity Indicator with swift 2.0
*/

let RappleTintColorKey = "TintColorKet"
let RappleBGColorKey = "BGColorKey"
let RappleIndicatorStyleKey = "IndicatorStyleKey"

let RappleStyleApple = "Apple"
let RappleStyleCircle = "Circle"

let RappleClassicAttribute : [String:AnyObject] = [RappleTintColorKey:UIColor.whiteColor(), RappleIndicatorStyleKey:RappleStyleApple, RappleBGColorKey:UIColor(white: 1.0, alpha: 0.0)]

let RappleModernAttribute : [String:AnyObject] = [RappleTintColorKey:UIColor.whiteColor(), RappleIndicatorStyleKey:RappleStyleCircle, RappleBGColorKey:UIColor(white: 0.0, alpha: 0.5)]

public class RappleActivityIndicatorView: NSObject {
    
    static let sharedInstance = RappleActivityIndicatorView()
    
    var backgroundView : UIView?
    var text : String?
    
    var attributes : [String:AnyObject] = [RappleTintColorKey:UIColor.whiteColor(), RappleIndicatorStyleKey:RappleStyleCircle, RappleBGColorKey:UIColor(white: 0.0, alpha: 0.5)]
    
    
    /**
     Start Rapple progress indicator without any text message
     */
    public class func startAnimating() {
        
        let keyWindow = UIApplication.sharedApplication().keyWindow
        keyWindow?.endEditing(true)
        keyWindow?.userInteractionEnabled = false
        
        let progress = RappleActivityIndicatorView.sharedInstance
        
        NSNotificationCenter.defaultCenter().addObserver(progress, selector: "deviceOrientationDidChange:", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        progress.createProgress()
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            progress.backgroundView?.alpha = 1.0
            
            }) { (finished) -> Void in
                progress.createProgressIndicator()
        }
    }
    
    /**
     Start Rapple progress indicator without any text message
     @param attribute progress UI attributes
     
     */
    public class func startAnimating(attributes attributes:[String:AnyObject]) {
        RappleActivityIndicatorView.sharedInstance.attributes = attributes
        RappleActivityIndicatorView.startAnimating()
    }
    
    /**
     Start Rapple progress indicator with text message
     */
    public class func startAnimatingWithLabel(label : String) {
        RappleActivityIndicatorView.sharedInstance.text = label
        RappleActivityIndicatorView.startAnimating()
    }
    
    /**
     Start Rapple progress indicator with text message
     @param attribute progress UI attributes
     */
    public class func startAnimatingWithLabel(label : String, attributes:[String:AnyObject]) {
        RappleActivityIndicatorView.sharedInstance.attributes = attributes
        RappleActivityIndicatorView.sharedInstance.text = label
        RappleActivityIndicatorView.startAnimating()
    }
    
    /**
     Start Rapple progress indicator
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
    
    func deviceOrientationDidChange(notif:NSNotification) {
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
    
    private func createProgress() {
        let keyWindow = UIApplication.sharedApplication().keyWindow
        
        let size = keyWindow?.bounds.size
        let max = size?.width > size?.height ? size?.width : size?.height
        let bgRect = CGRectMake(0, 0, max!, max!)
        
        backgroundView = UIView(frame: bgRect)
        backgroundView?.backgroundColor = attributes[RappleBGColorKey] as? UIColor
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
                squre.backgroundColor = UIColor(white: 0.0, alpha: 0.8)
                
                let indicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
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