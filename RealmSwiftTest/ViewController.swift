//
//  ViewController.swift
//  RealmSwiftTest
//
//  Created by Sean C Atkinson on 10/04/2015.
//  Copyright (c) 2015 Test. All rights reserved.
//

import UIKit
import Realm

class ViewController: UIViewController
{
    @IBOutlet weak var tableView:UITableView!
    
    var objects:RLMResults = TestObject.allObjects().sortedResultsUsingProperty("name", ascending: true)
    var realmNotificationToken:RLMNotificationToken?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        realmNotificationToken = RLMRealm.defaultRealm().addNotificationBlock({ [unowned self] (note, realm) -> Void in
            self.tableView.reloadData()
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let identifier = segue.identifier,
               cell = sender as? UITableViewCell,
               indexPath = tableView.indexPathForCell(cell)
            where identifier == "edit"
        {                
                let editVC:AddEditViewController = segue.destinationViewController as! AddEditViewController
                editVC.testObject = TestObject(object: objects[UInt(indexPath.row)])
        }
    }
    
    @IBAction func unwind(segue:UIStoryboardSegue)
    {}
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return Int(objects.count)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        let object:TestObject = TestObject(object: objects[UInt(indexPath.row)])
        cell.textLabel?.text = object.name
        return cell
    }
}

