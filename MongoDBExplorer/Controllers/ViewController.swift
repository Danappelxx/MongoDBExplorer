//
//  ViewController.swift
//  MongoDBExplorer
//
//  Created by Dan Appel on 11/15/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import UIKit
import SwiftMongoDB

class ViewController: UIViewController {

    var client: MongoClient!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        client = try! MongoClient(host: "localhost", port: 27017, database: "test")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigation = segue.destinationViewController as! UINavigationController

        let destination = navigation.viewControllers[0] as! DatabasesTableViewController
        destination.client = self.client
    }
}
