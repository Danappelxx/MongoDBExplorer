//
//  ViewController.swift
//  MongoDBExplorer
//
//  Created by Dan Appel on 11/15/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import UIKit
import SwiftMongoDB
import Bond

class ConnectViewController: UIViewController {

    var client: MongoClient!

    @IBOutlet weak var hostField: UITextField!
    @IBOutlet weak var databaseField: UITextField!
    @IBOutlet weak var connectButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let validate: (String? -> Bool) = { text in
            guard let text = text else { return false }
            guard text.characters.count > 0 else { return false }
            
            return true
        }

        let hostEmitter = hostField.bnd_text
            .map(validate)
        
        let databaseEmitter = databaseField.bnd_text
            .map(validate)

        let combined = hostEmitter
            .combineLatestWith(databaseEmitter)
            .map { $0 && $1 }

        combined
            .bindTo(connectButton.bnd_enabled)
            .disposeIn(bnd_bag)

        connectButton.bnd_tap
            .observe { [unowned self] in

                let host = self.hostField.bnd_text.value!
                let database = self.databaseField.bnd_text.value!

                do {
                    self.client = try MongoClient(host: host, port: 27017, database: database)

                    self.performSegueWithIdentifier("listDatabases", sender: self)

                } catch {
                    let error = error as! MongoError

                    let alert = UIAlertController(title: "Connection Failed", message: error.description, preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)

                    alert.addAction(okAction)

                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
            .disposeIn(bnd_bag)
        
        
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
