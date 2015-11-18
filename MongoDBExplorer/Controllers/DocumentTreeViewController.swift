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
import Bond

class DocumentTreeViewController: UIViewController {

    var viewModel: DocumentViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()


        let treeView = viewModel.treeView(frame: self.view.bounds)
        treeView.delegate = self
        treeView.dataSource = self

        view.addSubview(treeView)


        viewModel.treeData
            .observe { _ in
                treeView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DocumentTreeViewController: RATreeViewDelegate {
}

extension DocumentTreeViewController: RATreeViewDataSource {
    func treeView(treeView: RATreeView!, numberOfChildrenOfItem item: AnyObject!) -> Int {

        if item == nil {
            return self.viewModel.treeData.value.children?.count ?? 0
        }

        let data = DocumentTreeData(item: item)

        return data.children?.count ?? 0
    }

    func treeView(treeView: RATreeView!, cellForItem item: AnyObject!) -> UITableViewCell! {

        let cell = treeView.dequeueReusableCellWithIdentifier("documentTreeCell")

        let documentTreeCell = cell as! DocumentTreeTableViewCell

        let label = DocumentTreeData.descriptionForItem(item)

        documentTreeCell.colors = true
        documentTreeCell.label = label
        documentTreeCell.level = treeView.levelForCellForItem(item)

        return documentTreeCell
    }

    func treeView(treeView: RATreeView!, child index: Int, ofItem item: AnyObject!) -> AnyObject! {

        if item == nil {
            return self.viewModel.treeData.value.children?[index]
        }

        let data = DocumentTreeData(item: item)

        return data.children?[index]
    }
}
