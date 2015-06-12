//
//  AddViewController.swift
//  OpenInApp
//
//  Created by Elijah Frederickson on 6/9/15.
//  Copyright (c) 2015 Elijah Frederickson. All rights reserved.
//

import Foundation

class AddViewController : UIViewController, UITextViewDelegate
{
    @IBOutlet weak var labelTextField: UITextField!
    @IBOutlet weak var luaExpressionTextView: UITextView!
    @IBOutlet weak var replacementExpressionTextField: UITextView!
    
    override func viewDidLoad() {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
        
        luaExpressionTextView.delegate = self
        replacementExpressionTextField.delegate = self
    }
    
    @IBAction func saveButtonTap(sender: AnyObject) {
        var basePath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        var filePath = basePath + "user_created.plist"
        
        var dict : NSMutableDictionary? = NSMutableDictionary(contentsOfFile: filePath)
        if dict == nil
        {
            dict = NSMutableDictionary()
        }
        if dict?.objectForKey("user") == nil
        {
            dict?.setObject(NSMutableArray(), forKey: "user")
        }
        
        dict?.objectForKey("user")?.addObject([ labelTextField.text, luaExpressionTextView.text, replacementExpressionTextField.text ])
        
        dict?.writeToFile(filePath, atomically: true)
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.textViewDidEndEditing(luaExpressionTextView)
        self.textViewDidEndEditing(replacementExpressionTextField)
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.text == "twitter.com/[%w_]+/statuse-s-/(%d+)" || textView.text == "twitter://status/$1"
        {
            textView.text = ""
            textView.textColor = UIColor.blackColor()
        }
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text == ""
        {
            if textView == luaExpressionTextView
            {
                textView.text = "twitter.com/[%w_]+/statuse-s-/(%d+)"
            }
            else
            {
                textView.text = "twitter://status/$1"
            }
            textView.textColor = UIColor.grayColor()
        }
    }
    
}