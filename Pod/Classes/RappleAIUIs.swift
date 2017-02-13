/* **
 RappleAIUIs.swift
 Custom Activity Indicator with swift 3
 
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

/** creation of UIs */
extension RappleActivityIndicatorView {
    
    /** create background view */
    func createProgressBG() {
        if (backgroundView == nil){
            backgroundView = UIView(frame: CGRect.zero)
            backgroundView?.translatesAutoresizingMaskIntoConstraints = false
            backgroundView?.backgroundColor = getColor(key: RappleScreenBGColorKey).withAlphaComponent(0.4)
            backgroundView?.alpha = 1.0
            backgroundView?.isUserInteractionEnabled = false
            keyWindow.addSubview(backgroundView!)
            
            let dic = ["BG": backgroundView!]
            keyWindow.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[BG]|", options: .alignAllCenterY, metrics: nil, views: dic))
            keyWindow.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[BG]|", options: .alignAllCenterX, metrics: nil, views: dic))
        }
    }
    
    /** create all UIs */
    func createActivityIndicator(){
        if backgroundView == nil { createProgressBG() }
        clearUIs() // clear all before restart
        let style = attributes[RappleIndicatorStyleKey] as? String ?? RappleStyleCircle
        if style == RappleStyleApple {
            createAppleUIs()
        } else if style == RappleStyleCircle {
            createCircleUIs()
        } else if style == RappleStyleText {
            createTextUIs()
        }
    }
    
    /** create Apple style UIs */
    func createAppleUIs() {
        var sqWidth: CGFloat = 55
        // calc center values
        let size = calcTextSize(textLabel)
        let h = 45 + size.height
        let sqHeight: CGFloat = h + 20
        let cd = 24 + size.height - (h / 2)
        var c = keyWindow.center; c.y -= cd
        
        // add activity indicator
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator?.color = getColor(key: RappleTintColorKey)
        activityIndicator?.startAnimating()
        backgroundView?.addSubview(activityIndicator!)
        if showProgress == false {
            activityIndicator?.center = c
            sqWidth = size.width + 20
            if sqWidth < 55 { sqWidth = 55; }
        } else {
            var newc = c; newc.x -= 100
            activityIndicator?.center = newc
            sqWidth = 260
            
            progressBar = UIProgressView(progressViewStyle: .bar)
            progressBar?.frame = CGRect(x: 0, y: 0, width: 180, height: 4)
            progressBar?.center = CGPoint(x: c.x + 22, y: newc.y + 10)
            progressBar?.trackTintColor = getColor(key: RappleProgressBarColorKey)
            progressBar?.progressTintColor = getColor(key: RappleProgressBarFillColorKey)
            backgroundView?.addSubview(progressBar!)
            
            var rect = progressBar!.frame
            rect.origin.y -= 24
            rect.size.height = 21
            progressLabel = UILabel(frame: rect)
            progressLabel?.textColor = getColor(key: RappleTintColorKey)
            progressLabel?.textAlignment = .right
            backgroundView?.addSubview(progressLabel!)
            progressLabel?.text = ""
        }
        
        // add label and size
        activityLable = UILabel(frame: CGRect(x: 0, y: 0, width: size.width+1, height: size.height+1))
        let x = keyWindow.center.x
        let y = keyWindow.center.y - (size.height / 2) + (h / 2)
        activityLable?.center = CGPoint(x: x, y: y)
        activityLable?.font = UIFont.systemFont(ofSize: 16)
        activityLable?.textColor = getColor(key: RappleTintColorKey)
        activityLable?.textAlignment = .center
        activityLable?.numberOfLines = 0
        activityLable?.lineBreakMode = .byWordWrapping
        activityLable?.text = textLabel
        backgroundView?.addSubview(activityLable!)
        
        // set the rounded rectangle view at the middle
        contentSqure = UIView(frame: CGRect(x: 0, y: 0, width: sqWidth, height: sqHeight))
        contentSqure?.backgroundColor = getColor(key: RappleProgressBGColorKey)
        contentSqure?.layer.cornerRadius = 10.0
        contentSqure?.layer.masksToBounds = true
        contentSqure?.center = keyWindow.center
        backgroundView?.addSubview(contentSqure!)
        backgroundView?.sendSubview(toBack: contentSqure!)
        
        completionPoint = activityIndicator!.center
        completionPoint.x = contentSqure!.center.x
        completionRadius = 18
        completionWidth = 2
    }
    
    /** create circular UIs */
    func createCircleUIs() {
        let size = calcTextSize(textLabel)
        let yi = addAnimatingCircle(twoSided: showProgress == false)
        if showProgress == true {
            addProgresCircle(currentProgress, pgText: "")
        }
        activityLable = UILabel(frame: CGRect(x: 0, y: 0, width: size.width+1, height: size.height+1))
        let x = keyWindow.center.x
        let y = yi + (size.height / 2)
        activityLable?.center = CGPoint(x: x, y: y)
        activityLable?.textColor = getColor(key: RappleTintColorKey)
        activityLable?.font = UIFont.systemFont(ofSize: 16)
        activityLable?.textAlignment = .center
        activityLable?.numberOfLines = 0
        activityLable?.lineBreakMode = .byWordWrapping
        activityLable?.text = textLabel
        backgroundView?.addSubview(activityLable!)
    }
    
    /** create text UIs */
    func createTextUIs() {
        // add label and size
        let size = calcTextSize(textLabel)
        activityLable = UILabel(frame: CGRect(x: 0, y: 0, width: size.width+1, height: size.height+1))
        let x = keyWindow.center.x
        let y = keyWindow.center.y
        activityLable?.center = CGPoint(x: x, y: y)
        activityLable?.font = UIFont.systemFont(ofSize: 16)
        activityLable?.textColor = getColor(key: RappleTintColorKey)
        activityLable?.textAlignment = .center
        activityLable?.numberOfLines = 0
        activityLable?.lineBreakMode = .byWordWrapping
        activityLable?.text = textLabel
        backgroundView?.addSubview(activityLable!)
        
        let rect = activityLable!.frame
        progressLabel = UILabel(frame: CGRect(x: rect.maxX, y: rect.minY, width: 50, height: size.height+1))
        progressLabel?.font = UIFont.systemFont(ofSize: 16)
        progressLabel?.textColor = getColor(key: RappleTintColorKey)
        progressLabel?.textAlignment = .left
        progressLabel?.numberOfLines = 0
        progressLabel?.lineBreakMode = .byWordWrapping
        progressLabel?.text = ""
        backgroundView?.addSubview(progressLabel!)
        
        completionPoint = activityLable!.center
        completionRadius = 25
        
        textStyleVisible = true
        Thread.detachNewThreadSelector(#selector(RappleActivityIndicatorView.runTextStyle), toTarget: self, with: nil)
    }
    
    /** calc text value height - max 220x x 100 */
    func calcTextSize(_ text: String?) -> CGSize {
        if (text == nil) {
            return CGSize.zero
        }
        let nss = text! as NSString
        let size = nss.boundingRect(with: CGSize(width: 220, height: 9999), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)], context: nil).size
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
    func addAnimatingCircle(twoSided: Bool) -> CGFloat {
        
        let size = calcTextSize(textLabel)
        let r = radius
        let h = (2 * r) + size.height + 10
        let cd = (h - size.height - 10) / 2
        
        var center = keyWindow.center; center.y -= cd
        
        let circle1 = UIBezierPath(arcCenter: center, radius: r, startAngle: CGFloat(-M_PI_2), endAngle:CGFloat(3 * M_PI_2), clockwise: true)
        circularActivity1 = rotatingCircle(circle: circle1)
        
        if twoSided == true {
            let circle2 = UIBezierPath(arcCenter: center, radius: r, startAngle: CGFloat(M_PI_2), endAngle:CGFloat(5 * M_PI_2), clockwise: true)
            circularActivity2 = rotatingCircle(circle: circle2)
        }
        completionPoint = center
        completionRadius = (showProgress == true) ? r - 5 : r
        completionWidth = 4
        
        return center.y + r + 10
    }
    
    /** create circular path with UIBezierPath */
    func rotatingCircle(circle: UIBezierPath) -> CAShapeLayer {
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
        
        return shapeLayer
    }
    
    /** create & set circular progress bar */
    func addProgresCircle(_ progress: Float, pgText: String?) {
        
        if progressLayer == nil {
            let size = calcTextSize(textLabel)
            let r = radius
            let h = 2 * r + size.height + 10
            let cd = (h - size.height - 10) / 2
            
            var center = keyWindow.center; center.y -= cd
            let circle = UIBezierPath(arcCenter: center, radius: (r - 5), startAngle: CGFloat(-M_PI_2), endAngle:CGFloat(2 * M_PI - M_PI_2), clockwise: true)
            
            progressLayerBG = CAShapeLayer()
            progressLayerBG?.path = circle.cgPath
            progressLayerBG?.fillColor = nil
            progressLayerBG?.strokeColor = getColor(key: RappleProgressBarColorKey).cgColor
            progressLayerBG?.lineWidth = 4.0
            backgroundView?.layer.addSublayer(progressLayerBG!)
            
            progressLayer = CAShapeLayer()
            progressLayer?.path = circle.cgPath
            progressLayer?.fillColor = nil
            progressLayer?.strokeColor = getColor(key: RappleProgressBarFillColorKey).cgColor
            progressLayer?.lineWidth = 4.0
            backgroundView?.layer.addSublayer(progressLayer!)
            
            let w = (r * 2) - 10
            progressLabel = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: w))
            progressLabel?.center = center
            progressLabel?.textColor = getColor(key: RappleTintColorKey)
            progressLabel?.textAlignment = .center
            progressLabel?.numberOfLines = 0
            progressLabel?.lineBreakMode = .byWordWrapping
            backgroundView?.addSubview(progressLabel!)
        }
        var textVal = pgText
        if pgText == nil { textVal = "\(Int(progress * 100))%"; }
        progressLabel?.text = textVal
        
        progressLayer?.strokeStart = 0.0
        progressLayer?.strokeEnd = CGFloat(progress)
    }
    
    /** draw completion check mark */
    func drawCheckMark() {
        let x = completionPoint.x - 10
        let y = completionPoint.y + 4
        
        let circle = UIBezierPath(arcCenter: completionPoint, radius: completionRadius, startAngle: CGFloat(-M_PI_2), endAngle:CGFloat(2 * M_PI - M_PI_2), clockwise: true)
        let pgrsBg = CAShapeLayer()
        pgrsBg.path = circle.cgPath
        pgrsBg.fillColor = nil
        pgrsBg.strokeColor = getColor(key: RappleProgressBarFillColorKey).cgColor
        pgrsBg.lineWidth = completionWidth
        backgroundView?.layer.addSublayer(pgrsBg)
        
        let checkPath = UIBezierPath()
        checkPath.move(to: CGPoint(x: x, y: y))
        checkPath.addLine(to: CGPoint(x: x + 7, y: y + 5))
        checkPath.addLine(to: CGPoint(x: x + 18, y: y - 12))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = checkPath
            .cgPath
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = getColor(key: RappleProgressBarFillColorKey).cgColor
        shapeLayer.lineWidth = completionWidth
        backgroundView?.layer.addSublayer(shapeLayer)
    }
}
