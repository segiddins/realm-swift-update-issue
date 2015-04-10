//
//  AddEditViewController.swift
//  RealmSwiftTest
//
//  Created by Sean C Atkinson on 10/04/2015.
//  Copyright (c) 2015 Test. All rights reserved.
//

import UIKit
import Realm

class AddEditViewController: UIViewController
{
    @IBOutlet weak var textField:UITextField!
    
    var testObject:TestObject?
}

extension AddEditViewController
{
    @IBAction func saveButtonPressed(sender:UIButton)
    {
        let result = saveTestObject()
        if result == false {
            textField.backgroundColor = UIColor.redColor()
            textField.textColor = UIColor.whiteColor()
        } else {
           self.performSegueWithIdentifier("unwind", sender: sender)
        }
    }
    
    func saveTestObject() -> Bool
    {
        if count(textField.text) < 1 {
            return false
        }
        
        if let testObject = testObject {
            updateTestObject(testObject)
        } else {
            createTestObject()
        }
        
        return true
    }
    
    func createTestObject() -> TestObject
    {
        let object = TestObject()
        object.name = textField.text
        
        let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        realm.addObject(object)
        realm.commitWriteTransaction()
        
        return object
    }
    
    func updateTestObject(object:TestObject) -> TestObject
    {
        let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        object.name = textField.text
        realm.commitWriteTransaction()
        
        return object
    }
}
