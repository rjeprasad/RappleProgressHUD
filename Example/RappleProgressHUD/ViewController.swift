//
//  ViewController.swift
//  RappleProgressHUD
//
//  Created by Rajeev Prasad on 11/15/2015.
//  Copyright (c) 2015 Rajeev Prasad. All rights reserved.
//

import UIKit
import RappleProgressHUD

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startModernProgress(sender : AnyObject?) {
        RappleActivityIndicatorView.startAnimatingWithLabel("Loading...", attributes: RappleModernAttributes)
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "stopAnimation", userInfo: nil, repeats: false)
    }
    
    @IBAction func startAppleProgress(sender : AnyObject?) {
        RappleActivityIndicatorView.startAnimatingWithLabel("Loading...", attributes: RappleAppleAttributes)
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "stopAnimation", userInfo: nil, repeats: false)
    }
    
    func stopAnimation(){
        RappleActivityIndicatorView.stopAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

