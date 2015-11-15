//
//  RappleActivityIndicatorView.swift
//  Pods
//
//  Created by Rajeev Prasad on 15/11/15.
//
//

import UIKit

/*!
RappleActivityIndicatorView - Custom Activity Indicator with swift 2.0
*/
public class RappleActivityIndicatorView: NSObject {
    
    static let sharedInstance = RappleActivityIndicatorView()
    
    var backgroundView : UIView!
    var text : String?
    
    override init() {
        super.init()
        
        
    }
    
    public class func startAnimating() {
        
        let keyWindow = UIApplication.sharedApplication().keyWindow
        keyWindow?.endEditing(true)
        keyWindow?.userInteractionEnabled = false
        
        let view = RappleActivityIndicatorView.sharedInstance
        
        NSNotificationCenter.defaultCenter().addObserver(view, selector: "deviceOrientationDidChange:", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        view.createProgress()
        
        UIView.animateWithDuration(0.8) { () -> Void in
            view.backgroundView.alpha = 1.0
        }
    }
    
    public class func startAnimatingWithLabel(label : String) {
        RappleActivityIndicatorView.sharedInstance.text = label
        RappleActivityIndicatorView.startAnimating()
    }
    
    public class func stopAnimating() {
        let keyWindow = UIApplication.sharedApplication().keyWindow
        keyWindow?.userInteractionEnabled = true
        
        let view = RappleActivityIndicatorView.sharedInstance
        
        view.backgroundView.layer.sublayers = nil
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            view.backgroundView.alpha = 0.0
            keyWindow?.tintAdjustmentMode = .Automatic
            keyWindow?.tintColorDidChange()
            }) { (finished) -> Void in
                let views = view.backgroundView.subviews
                for v in views {
                    v.removeFromSuperview()
                }
                view.backgroundView.removeFromSuperview()
        }
        
        NSNotificationCenter.defaultCenter().removeObserver(view)
    }
    
    func deviceOrientationDidChange(notif:NSNotification) {
        let view = RappleActivityIndicatorView.sharedInstance
        let views = view.backgroundView.subviews
        for v in views {
            v.removeFromSuperview()
        }
        view.backgroundView.removeFromSuperview()
        
        view.createProgress()
    }
    
    private func createProgress() {
        let keyWindow = UIApplication.sharedApplication().keyWindow
        
        let size = keyWindow?.bounds.size
        let max = size?.width > size?.height ? size?.width : size?.height
        let bgRect = CGRectMake(0, 0, max!, max!)
        
        backgroundView = UIView(frame: bgRect)
        backgroundView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        backgroundView.alpha = 1.0
        backgroundView.userInteractionEnabled = false
        keyWindow?.addSubview(backgroundView)
        
        let label = UILabel(frame: CGRectMake(0, 0, (keyWindow?.bounds.size.width)! - 20, 21))
        label.center = CGPointMake((keyWindow?.center.x)!, (keyWindow?.center.y)! + 40)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        label.text = text
        backgroundView.addSubview(label)
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.addAnimatingCircle()
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
        self.backgroundView.layer.addSublayer(shapeLayer)
        
        
        
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
