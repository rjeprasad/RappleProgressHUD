/* **
 RappleAIPrivate.swift
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

/** general methods */
extension RappleActivityIndicatorView {
    
    /** get color attribute values for key */
    @objc func getColor(key: String) -> UIColor {
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
            return UIColor.lightGray.withAlphaComponent(0.8)
        case RappleProgressBarFillColorKey:
            return UIColor.white.withAlphaComponent(0.9)
        default:
            return UIColor.white.withAlphaComponent(0.8)
        }
    }
    
    @objc func getThickness(adjustment: CGFloat = 0) -> CGFloat {
        if let thick = attributes[RappleIndicatorThicknessKey] as? CGFloat {
            if thick > adjustment {
                return thick - adjustment
            } else {
                return 1
            }
        }
        return 4.0 - adjustment
    }
    
    
    /** get completion indicator string value */
    func getCompletion(indicator: RappleCompletion) -> (String, UIFont) {
        switch indicator {
        case .success:
            return ("✓", .boldSystemFont(ofSize: 25))
        case .failed:
            return ("✕", .systemFont(ofSize: 25))
        case .incomplete:
            return ("!", .boldSystemFont(ofSize: 27))
        case .unknown:
            return ("?", .boldSystemFont(ofSize: 25))
        case .none:
            return ("", .systemFont(ofSize: 22))
        }
        
    }
    
    /** re-create after orientation change */
    @objc internal func orientationChanged() {
        RappleActivityIndicatorView.sharedInstance.createActivityIndicator()
    }
    
    /** clear all UIs */
    @objc func clearUIs() {
        if let bgview = RappleActivityIndicatorView.sharedInstance.backgroundView {
            for v in bgview.subviews {
                v.removeFromSuperview()
            }
            if let layers = bgview.layer.sublayers {
                for l in layers {
                    l.removeFromSuperlayer()
                }
            }
            progressLayer = nil
            progressLayerBG = nil
            progressLabel = nil
        }
    }
    
    /** get key window */
    @objc var keyWindow: UIWindow {
        return UIApplication.shared.keyWindow!
    }
}

