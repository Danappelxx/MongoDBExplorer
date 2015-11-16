//
//  CollectionsTableViewController.swift
//  MongoDBExplorer
//
//  Created by Dan Appel on 11/15/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import UIKit
import SwiftMongoDB

class CollectionsTableViewController: UITableViewController {

    var client: MongoClient!
    var database: String!
    var collections: [String]!
    var selectedCollection: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        print(database)
        collections = client.getCollectionNamesInDatabase(database)
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
        return collections.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("collectionCell", forIndexPath: indexPath)

        let collectionCell = cell as! CollectionsTableViewCell

        // Configure the cell...
        collectionCell.collectionName = collections[indexPath.row]

        return collectionCell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("selected collection: \(collections[indexPath.row])")
        selectedCollection = collections[indexPath.row]
        performSegueWithIdentifier("listDocuments", sender: self)
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        let destination = segue.destinationViewController as! DocumentTreeViewController
        destination.collectionName = selectedCollection
        destination.collection = MongoCollection(collectionName: destination.collectionName, client: client)
    }

}
