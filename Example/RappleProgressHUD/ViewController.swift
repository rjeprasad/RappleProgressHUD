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
    
    func startModernProgress() {
        RappleActivityIndicatorView.startAnimatingWithLabel("Processing...", attributes: RappleModernAttributes)
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.stopAnimation), userInfo: nil, repeats: false)
    }
    
    func startModernProgressWithBar() {
        RappleActivityIndicatorView.startAnimatingWithLabel("Downloading...", attributes: RappleModernAttributes)
        Thread.detachNewThreadSelector(#selector(ViewController.runProgress), toTarget: self, with: nil)
    }
    
    func startAppleProgress() {
        RappleActivityIndicatorView.startAnimatingWithLabel("Processing...", attributes: RappleAppleAttributes)
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(ViewController.stopAnimation), userInfo: nil, repeats: false)
    }
    
    func startAppleProgressWithBar() {
        RappleActivityIndicatorView.startAnimatingWithLabel("Downloading...", attributes: RappleAppleAttributes)
        Thread.detachNewThreadSelector(#selector(ViewController.runProgress), toTarget: self, with: nil)
    }
    
    func runProgress() {
        var i: CGFloat = 0
        while i <= 100 {
            RappleActivityIndicatorView.setProgress(i/100)
            i += 1
            Thread.sleep(forTimeInterval: 0.05)
        }
        RappleActivityIndicatorView.stopAnimating()
    }
    
    func stopAnimation(){
        RappleActivityIndicatorView.stopAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.textLabel?.text = "Apple Style Activity Indicator."
            } else {
                cell.textLabel?.text = "Apple Style Activity Indicator\nwith progress bar."
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.textLabel?.text = "Modern Style Activity Indicator."
            } else {
                cell.textLabel?.text = "Modern Style Activity Indicator\nwith progress bar."
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                startAppleProgress()
            } else {
                startAppleProgressWithBar()
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                startModernProgress()
            } else {
                startModernProgressWithBar()
            }
        }
    }
}
