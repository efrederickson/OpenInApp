//
//  DownwardSwipeSegue.swift
//  h
//
//  Created by Andi Andreas on 6/6/15.
//  Copyright (c) 2015 Deplex. All rights reserved.
//

import UIKit

class DownwardSwipeSegue: UIStoryboardSegue {
    override func perform() {
        var originalView = self.sourceViewController.view as UIView!
        var newView = self.destinationViewController.view as UIView!
        
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(newView, belowSubview: originalView)
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            originalView.frame = CGRectOffset(originalView.frame, 0.0, screenHeight)
        }) { (finished) -> Void in
            self.sourceViewController.presentViewController(self.destinationViewController as! UIViewController, animated: false, completion: nil)
            //(UIApplication.sharedApplication().delegate as! AppDelegate!).introWindow = nil
        }
    }
}
