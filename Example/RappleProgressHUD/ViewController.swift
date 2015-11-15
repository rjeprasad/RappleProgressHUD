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
    
    @IBAction func startProgress(sender : AnyObject?) {
        RappleActivityIndicatorView.startAnimatingWithLabel("Loading...");
        // to stop programetically call
        // RappleActivityIndicatorView.stopAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

