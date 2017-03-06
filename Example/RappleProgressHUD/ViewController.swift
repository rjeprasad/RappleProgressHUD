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
    
    @IBOutlet var styleSeg: UISegmentedControl!
    @IBOutlet var barSwitch: UISwitch!
    @IBOutlet var cmplSeg: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startDefault(_ sender: UIButton) {
        var timeOut: TimeInterval = 2
        switch styleSeg.selectedSegmentIndex {
        case 0:
            RappleActivityIndicatorView.startAnimatingWithLabel("Processing...", attributes: RappleAppleAttributes)
        case 1:
            RappleActivityIndicatorView.startAnimatingWithLabel("Processing...", attributes: RappleModernAttributes)
        case 2:
            RappleActivityIndicatorView.startAnimatingWithLabel("Processing", attributes: RappleTextAttributes)
            timeOut = 5
        default: ()
        }
        
        if barSwitch.isOn == true && styleSeg.selectedSegmentIndex != 2 {
            Thread.detachNewThreadSelector(#selector(runProgress), toTarget: self, with: nil)
        } else {
            Timer.scheduledTimer(timeInterval: timeOut, target: self, selector: #selector(stopAnimation), userInfo: nil, repeats: false)
        }
        
        
    }
    
    func runProgress() {
        if styleSeg.selectedSegmentIndex != 2 {
            var i: CGFloat = 0
            while i <= 100 {
                RappleActivityIndicatorView.setProgress(i/100)
                i += 1
                Thread.sleep(forTimeInterval: 0.01)
            }
        }
        self.stopAnimation()
    }
    
    func stopAnimation(){
        switch self.cmplSeg.selectedSegmentIndex {
        case 0:
            RappleActivityIndicatorView.stopAnimation()
        case 1:
            RappleActivityIndicatorView.stopAnimation(completionIndicator: .success, completionLabel: "Completed.", completionTimeout: 1.0)
        case 2:
            RappleActivityIndicatorView.stopAnimation(completionIndicator: .failed, completionLabel: "Failed.", completionTimeout: 1.0)
        case 3:
            RappleActivityIndicatorView.stopAnimation(completionIndicator: .incomplete, completionLabel: "Incomplete.", completionTimeout: 1.0)
        case 4:
            RappleActivityIndicatorView.stopAnimation(completionIndicator: .unknown, completionLabel: "Unknown.", completionTimeout: 1.0)
        default: ()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
