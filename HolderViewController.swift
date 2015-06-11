//
//  HolderViewController.swift
//  h
//
//  Created by Andi Andreas on 6/6/15.
//  Copyright (c) 2015 Deplex. All rights reserved.
//

import UIKit

class HolderViewController: UIViewController {
    
    var pageIndex: Int = 0
    var timer: NSTimer?
    
    let greetings = [
        "Hallo.",
        "Bonjour.",
        "Ciao.",
        "Olá.",
        "Salut.",
        "Hola.",
        "Marhaba.",
        "Hej.",
        "Hello.",
    ]

    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var hiLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (blurView != nil) {
            blurView.clipsToBounds = true
            blurView.alpha = 0.65
            blurView.layer.cornerRadius = 15
        }
        if (pageIndex == 3) {
            var swipeRecognizer = UISwipeGestureRecognizer(target: self, action: "swipedDownward")
            swipeRecognizer.direction = .Down
            self.view.addGestureRecognizer(swipeRecognizer)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (hiLabel != nil) {
            timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("animateGreeting"), userInfo: nil, repeats: true)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if (timer != nil) {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func animateGreeting() {
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.hiLabel.alpha = 0
        }) { (finished) -> Void in
            UIView.animateWithDuration(1, animations: { () -> Void in
                let randomIndex = Int(arc4random_uniform(UInt32(self.greetings.count)))
                self.hiLabel.text = self.greetings[randomIndex]
                self.hiLabel.alpha = 1
            }, completion: nil)
        }
    }
    
    func swipedDownward() {
        self.parentViewController!.parentViewController!.performSegueWithIdentifier("transition", sender: self)
    }
    
    @IBAction func confusedButtonTapped(sender: AnyObject) {
        var alert = UIAlertController(title: "THIS IS A TITLE", message: "THIS IS A MESSAGE", preferredStyle: .Alert)
        var cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
