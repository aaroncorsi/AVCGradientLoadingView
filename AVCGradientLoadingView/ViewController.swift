//
//  ViewController.swift
//  AVCGradientLoadingView
//
//  Created by Aaron Corsi on 5/11/18.
//  Copyright © 2018 Aaron Corsi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var loadingView: AVCGradientLoadingView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func prefersHomeIndicatorAutoHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Tap to simulate completion of loading
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissLoadingView))
        self.view.addGestureRecognizer(tapRecognizer)
        
        // Simulate completion of loading with a timer
//        _ = Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { (timer) in
//            self.loadingView.dismiss()
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func dismissLoadingView() {
        // Dismiss the current loading view
        self.loadingView.dismiss { (finished) in
            if finished {
                self.loadingView.removeFromSuperview()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

