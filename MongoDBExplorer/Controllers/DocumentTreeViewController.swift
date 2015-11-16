//
//  DocumentTreeViewController.swift
//  MongoDBExplorer
//
//  Created by Dan Appel on 11/15/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import UIKit
import SwiftMongoDB
import RATreeView

class DocumentTreeViewController: UIViewController {

    var collectionName: String!
    var collection: MongoCollection!
    var documents: [DocumentData]!
    var data: DocumentTreeData!

    var treeView: RATreeView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        documents = try! collection.find().map { $0.data }
        data = DocumentTreeData(item: documents)

        // load tree view
        treeView = RATreeView(frame: self.view.bounds, style: RATreeViewStylePlain)
        treeView.delegate = self
        treeView.dataSource = self

        treeView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        view.addSubview(treeView)

        treeView.registerNib(UINib(nibName: "DocumentTreeTableViewCell", bundle: nil), forCellReuseIdentifier: "documentTreeCell")

        treeView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DocumentTreeViewController: RATreeViewDelegate {
}

extension DocumentTreeViewController: RATreeViewDataSource {
    func treeView(treeView: RATreeView!, numberOfChildrenOfItem item: AnyObject!) -> Int {

        if item == nil {
            return self.data.children!.count
        }

        let data = DocumentTreeData(item: item)

        return data.children?.count ?? 0
    }

    func treeView(treeView: RATreeView!, cellForItem item: AnyObject!) -> UITableViewCell! {

        var label = item.description

        if let data = item as? DocumentData {
            let keys = [String](data.keys)

            label = keys.joinWithSeparator(", ")
        }

        let cell = treeView.dequeueReusableCellWithIdentifier("documentTreeCell")

        let documentTreeCell = cell as! DocumentTreeTableViewCell

        documentTreeCell.colors = true
        documentTreeCell.label = label
        documentTreeCell.level = treeView.levelForCellForItem(item)

        return documentTreeCell
    }

    func treeView(treeView: RATreeView!, child index: Int, ofItem item: AnyObject!) -> AnyObject! {

        if item == nil {
            return self.data.children?[index]
        }

        let data = DocumentTreeData(item: item)

        return data.children?[index]
    }
}
