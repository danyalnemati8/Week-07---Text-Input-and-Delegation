//
//  ViewController.swift
//  Week 07 - Text Input and Delegation
//
//  Created by Danyal Nemati on 9/28/23.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var phoneField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passField: UITextField!
    
    var patternChecker = PatternChecker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backgroundTapped(_ sender:UITapGestureRecognizer){
        
        self.nameField.resignFirstResponder()
        self.phoneField.resignFirstResponder()
        self.emailField.resignFirstResponder()
        self.passField.resignFirstResponder()
        print("Background tapped!")
    }
    
    func textField(
        _ textField:UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    )-> Bool
    {
        var acceptChanges = true
        
        let text_original = textField.text ?? ""
        var text_new = String(text_original)
        guard let sRange = Range(range, in: text_original) else {return false}
        text_new.replaceSubrange(sRange, with: string)
        
        
        print("Original text: \(text_original)")
        print("Changing to: \(text_new)")
        
        switch(textField.textContentType){
        case UITextContentType.emailAddress:
            print("Checking email change")
            if self.patternChecker.checkEmailString(text_new){
                print("Email change seems to be okay")
            }
            else{
                print("Email change rejected!")
                acceptChanges = false
            }
        case UITextContentType.telephoneNumber:
            print("Checking phone number change")
            if self.patternChecker.checkPhoneString(text_new){
                print("Phone change seems to be okay")
            }
            else{
                print("Phone change rejected!")
                acceptChanges = false
            }
        default:
            print("Default content type; Won't check against pattern")
            //        print("Current text: \(String(describing: textField.text))")
            //        print("Replacement text: \(string)")
            
            //        if(string.contains("z")){
            //            acceptChanges = false
            //        }
            
        }
        
        return acceptChanges
    }
    
}
