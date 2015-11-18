//
//  DocumentViewModel.swift
//  MongoDBExplorer
//
//  Created by Dan Appel on 11/17/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import Foundation
import Bond
import SwiftMongoDB
import RATreeView

class DocumentViewModel {

    let documents = Observable([MongoDocument]())
    let query = Observable(DocumentData())
    let treeData = Observable(DocumentTreeData(item: nil))

    let collection: MongoCollection

    init(collection: MongoCollection) {
        self.collection = collection

        setupObservers()
    }
    
    func setupObservers() {

        query
            .observe { query in
                if let docs = try? self.collection.find(query) {
                    self.documents.next(docs)
                } else {
                    self.documents.next([])
                }
            }

        documents
            .map {
                $0.map { $0.data }
            }
            .observe { docs in
                let data = DocumentTreeData(item: docs)
                self.treeData.next(data)
            }
    }

    func treeView(frame frame: CGRect) -> RATreeView {
        let treeView = RATreeView(frame: frame, style: RATreeViewStylePlain)

        treeView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        treeView.registerNib(UINib(nibName: "DocumentTreeTableViewCell", bundle: nil), forCellReuseIdentifier: "documentTreeCell")

        return treeView
    }
}
