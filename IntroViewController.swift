//
//  ViewController.swift
//  OpenInAppWelcome
//
//  Created by Andrew Abosh on 2015-05-26.
//  Copyright (c) 2015 Andrew Abosh. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, UIPageViewControllerDataSource {

    var pageViewController: UIPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
        // Make the page view controller programatically
        pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController!.dataSource = self
        // Why this has to be in an array, only Apple knows
        let startingViewController: HolderViewController = viewControllerAtIndex(0)
        let viewControllers: NSArray = [startingViewController]
        pageViewController!.setViewControllers(viewControllers as [AnyObject], direction: .Forward, animated: false, completion: nil)
        // Set the view frame equal to the main view controller's frame
        pageViewController!.view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        // Finally, add the new page view controller to this view controller
        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    // Changed from viewDidAppear. This way it simply hides the view, instead of sliding down
    override func viewWillAppear(animated: Bool) {
        let didShowIntro: Bool = NSUserDefaults.standardUserDefaults().boolForKey("didShowIntro")
        if !didShowIntro
        {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "didShowIntro")
            NSUserDefaults.standardUserDefaults().synchronize()
            NSLog("Did not show intro")
        }
        else
        {
            self.view.alpha = 0
            self.performSegueWithIdentifier("transition2", sender: self)
            NSLog("Did show intro")
        }
    }
    
    func viewControllerAtIndex(index: Int) -> HolderViewController {
        let vc = HolderViewController(nibName: "\(index)", bundle: nil)
        vc.pageIndex = index
        return vc
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! HolderViewController).pageIndex
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index--
        return viewControllerAtIndex(index)

        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! HolderViewController).pageIndex
        if index == NSNotFound {
            return nil
        }
        index++
        if (index == 4) {
            return nil
        }
        return viewControllerAtIndex(index)
    }
    
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return 4
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return 0
    }
    
    
    
}

