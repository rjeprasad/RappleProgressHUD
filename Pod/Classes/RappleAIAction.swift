/* **
 RappleAIAction.swift
 Custom Activity Indicator with swift 4
 
 Created by Rajeev Prasad on 18/12/16.
 
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


/** calling actions */
extension RappleActivityIndicatorView {
    
    /** isVisible */
    @objc class func isPrivateVisible() -> Bool {
        let progress = RappleActivityIndicatorView.sharedInstance
        return progress.backgroundView?.superview != nil
    }
    
    /** create & start */
    @objc class func startPrivateAnimating() {
                
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
    @objc class func startPrivateAnimating(attributes:[String:Any]) {
        RappleActivityIndicatorView.sharedInstance.setAttributeDict(attributes: attributes)
        RappleActivityIndicatorView.startPrivateAnimating()
    }
    
    /** create & start */
    @objc class func startPrivateAnimatingWithLabel(_ label : String) {
        RappleActivityIndicatorView.sharedInstance.textLabel = label
        RappleActivityIndicatorView.startPrivateAnimating()
    }
    
    /** create & start */
    @objc class func startPrivateAnimatingWithLabel(_ label : String, attributes:[String:Any]) {
        RappleActivityIndicatorView.sharedInstance.setAttributeDict(attributes: attributes)
        RappleActivityIndicatorView.sharedInstance.textLabel = label
        RappleActivityIndicatorView.startPrivateAnimating()
    }
    
    /** stop & clear */
    class func stopPrivateAnimating(indicator: RappleCompletion, completionLabel: String?, completionTimeout: TimeInterval) {
        
        if indicator == .success || indicator == .failed ||
            indicator == .incomplete || indicator == .unknown {
            
            let style = sharedInstance.attributes[RappleIndicatorStyleKey] as? String ?? RappleStyleCircle
            if style == RappleStyleApple {
                sharedInstance.progressBar?.removeFromSuperview()
                sharedInstance.activityIndicator?.removeFromSuperview()
                
                if sharedInstance.contentSqure != nil {
                    var sqWidth: CGFloat = 55
                    // calc center values
                    var comLabel = completionLabel
                    if RappleActivityIndicatorView.sharedInstance.textLabel == nil {
                        comLabel = nil
                    }
                    let size = sharedInstance.calcTextSize(comLabel)
                    sqWidth = size.width + 20
                    if sqWidth < 55 { sqWidth = 55; }
                    let c = sharedInstance.contentSqure?.center
                    var rect = sharedInstance.contentSqure?.frame
                    rect?.size.width = sqWidth
                    sharedInstance.contentSqure?.frame = rect!
                    sharedInstance.contentSqure?.center = c!
                }
                
            } else if style == RappleStyleCircle {
                sharedInstance.circularActivity1?.removeFromSuperlayer()
                sharedInstance.circularActivity2?.removeFromSuperlayer()
                sharedInstance.progressLayer?.removeFromSuperlayer()
                sharedInstance.progressLayerBG?.removeFromSuperlayer()
            } else if style == RappleStyleText {
                sharedInstance.dotCount = 0
                sharedInstance.textStyleVisible = false
                var c = sharedInstance.activityLable!.center; c.y += 40
                sharedInstance.activityLable?.center = c
                sharedInstance.activityLable?.textAlignment = .center
            }
            sharedInstance.completionLabel?.removeFromSuperview()
            sharedInstance.progressLabel?.removeFromSuperview()
            sharedInstance.activityLable?.text = completionLabel
            
            sharedInstance.drawCheckMark(indicator: indicator)
            
            Timer.scheduledTimer(timeInterval: completionTimeout, target: sharedInstance, selector: #selector(RappleActivityIndicatorView.closePrivateActivityCompletion), userInfo: nil, repeats: false)
        }
        else {
            sharedInstance.textStyleVisible = false
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                sharedInstance.backgroundView?.alpha = 0.0
                sharedInstance.keyWindow.tintAdjustmentMode = .automatic
                sharedInstance.keyWindow.tintColorDidChange()
            }, completion: { (finished) -> Void in
                sharedInstance.clearUIs()
                sharedInstance.backgroundView?.removeFromSuperview()
                sharedInstance.backgroundView = nil
                sharedInstance.keyWindow.isUserInteractionEnabled = true
                
                if sharedInstance.attributes[RappleIndicatorStyleKey] as? String == RappleStyleText {
                    sharedInstance.dotCount = 0
                    sharedInstance.textStyleVisible = false
                    sharedInstance.activityLable?.removeFromSuperview() // only text value is available
                }
            })
        }
        NotificationCenter.default.removeObserver(sharedInstance)
    }
    
    /** close completion UIs */
    @objc internal func closePrivateActivityCompletion() {
        RappleActivityIndicatorView.stopPrivateAnimating(indicator: .none, completionLabel: nil, completionTimeout: 0)
    }
    
    /** set progress values
     - not available with RappleStyleText mode
     */
    @objc class func setPrivateProgress(_ progress: Float, textValue: String? = nil) {
        let style = sharedInstance.attributes[RappleIndicatorStyleKey] as? String ?? RappleStyleCircle
        if style == RappleStyleText { /* not available */ return; }
        
        if progress >= 0 && progress <= 1.0 {
            sharedInstance.currentProgress = progress
            if sharedInstance.showProgress == false {
                sharedInstance.showProgress = true
                sharedInstance.createActivityIndicator()
            }
            
            if style == RappleStyleApple {
                sharedInstance.setBarProgressValue(progress, pgText: textValue)
            } else if style == RappleStyleCircle {
                sharedInstance.addProgresCircle(progress, pgText: textValue)
            }
            
        } else {
            print("Error RappleActivityIndicatorView: Invalid progress value")
        }
    }
    
    @objc func setBarProgressValue(_ progress: Float, pgText: String?){
        progressBar?.progress = progress
        var textVal = pgText
        if pgText == nil {
            textVal = "\(Int(progress * 100))%";
        }
        progressLabel?.text = textVal
    }
    
    @objc  func runTextStyle() {
        while textStyleVisible == true {
            self.changeTextValue()
            Thread.sleep(forTimeInterval: 0.5)
        }
    }
    
    @objc func changeTextValue() {
        var dots = ""
        let c = (dotCount % 4) + 1
        for _ in 1...c { dots.append("."); }
        DispatchQueue.main.async {
            self.progressLabel?.text = dots
        }
        dotCount += 1
    }
    
}
