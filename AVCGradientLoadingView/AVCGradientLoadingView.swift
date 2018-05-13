//
//  AVCGradientLoadingView.swift
//  AVCGradientLoadingView
//
//  Created by Aaron Corsi on 5/11/18.
//  Copyright © 2018 Aaron Corsi. All rights reserved.
//

import UIKit

class AVCGradientLoadingView: UIView {
    private let gradientBackgroundLayer = CAGradientLayer()
    private let imageMaskView = UIImageView()
    private let gradientAnimationKey = "animate_gradient"
    
    @IBInspectable var animationSpeed: Double = 2 {
        didSet {
            self.updateAnimation()
        }
    }
    @IBInspectable var imageMask: UIImage = #imageLiteral(resourceName: "AaronCorsi_logo") {
        didSet {
            self.imageMaskView.image = imageMask
        }
    }
    @IBInspectable var gradientStartColor: UIColor = UIColor(hue: 22/360, saturation: 1, brightness: 1, alpha: 1) {
        didSet {
            self.updateGradientColors()
        }
    }
    @IBInspectable var gradientEndColor: UIColor = UIColor(hue: 304/360, saturation: 1, brightness: 1, alpha: 1) {
        didSet {
            self.updateGradientColors()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set up gradient background
        self.gradientBackgroundLayer.frame = CGRect(x: -self.bounds.width * 2.5, y: 0, width: self.bounds.width * 4, height: self.bounds.height)
        self.updateGradientColors()
        self.gradientBackgroundLayer.startPoint = CGPoint(x: 0, y: 0.5)
        self.gradientBackgroundLayer.endPoint = CGPoint(x: 1, y: 0.5)
        self.layer.addSublayer(gradientBackgroundLayer)
        
        // Set up animation
        self.updateAnimation()
        
        // Set up mask
        self.imageMaskView.frame = self.bounds
        self.imageMaskView.image = self.imageMask
        self.mask = self.imageMaskView
    }

    func updateGradientColors() {
        self.gradientBackgroundLayer.colors = [gradientStartColor.cgColor, gradientEndColor.cgColor, gradientStartColor.cgColor, gradientEndColor.cgColor, gradientStartColor.cgColor]
    }
    
    func updateAnimation() {
        self.gradientBackgroundLayer.removeAnimation(forKey: self.gradientAnimationKey)
        let animation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.position))
        animation.fromValue = self.gradientBackgroundLayer.position
        animation.toValue = CGPoint(x: self.gradientBackgroundLayer.position.x + self.bounds.width * 2, y: self.gradientBackgroundLayer.position.y)
        animation.repeatCount = Float.greatestFiniteMagnitude
        animation.duration = self.animationSpeed
        self.gradientBackgroundLayer.add(animation, forKey: self.gradientAnimationKey)
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = self.transform.scaledBy(x: 1.1, y: 1.1)
        }) { (finished) in
            if finished {
                UIView.animate(withDuration: 0.2, animations: {
                    self.transform = self.transform.scaledBy(x: 0.01, y: 0.01)
                    self.alpha = 0
                }, completion: nil)
            }
        }
    }
}
