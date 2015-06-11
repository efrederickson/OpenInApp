//
//  GradientView.swift
//  h
//
//  Created by Andi Andreas on 6/4/15.
//  Copyright (c) 2015 Deplex. All rights reserved.
//

import UIKit

class GradientView: UIView {
    var gradientLayer: CAGradientLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if (self.gradientLayer == nil) {
            self.gradientLayer = CAGradientLayer()
            self.gradientLayer!.opacity = 1
        }
        var firstColor = UIColor(red: (196/255.0), green: (86/255.0), blue: (248/255.0), alpha: 1.0)
        var secondColor = UIColor(red: (107/255.0), green: (99/255.0), blue: (231/255.0), alpha: 1.0)
        var colors: [CGColor] = [firstColor.CGColor, secondColor.CGColor]
        self.gradientLayer!.colors = colors
        self.tintColor = UIColor.clearColor()
        self.gradientLayer!.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))
        self.layer.insertSublayer(self.gradientLayer, atIndex: 1)
        
        
    }
}
