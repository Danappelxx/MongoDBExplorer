//
//  DatabasesTableViewController.swift
//  MongoDBExplorer
//
//  Created by Dan Appel on 11/15/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import UIKit
import SwiftMongoDB

class DatabasesTableViewController: UITableViewController {

    var client: MongoClient!
    var databases: [String]!
    var selectedDatabase: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.databases = client.getDatabaseNames()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return databases.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("databaseCell", forIndexPath: indexPath)

        let databaseCell = cell as! DatabaseTableViewCell

        // Configure the cell...
        databaseCell.databaseName = databases[indexPath.row]

        return databaseCell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("selected database: \(databases[indexPath.row])")
        selectedDatabase = databases[indexPath.row]
        performSegueWithIdentifier("listCollections", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        let destination = segue.destinationViewController as! CollectionsTableViewController
        destination.client = self.client
        destination.database = selectedDatabase
    }

}
