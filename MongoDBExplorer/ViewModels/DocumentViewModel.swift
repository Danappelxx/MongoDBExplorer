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
    let limit = Observable(50)
    let treeData = Observable(DocumentTreeData(item: nil))

    let collection: MongoCollection

    init(collection: MongoCollection) {
        self.collection = collection

        setupObservers()
    }
    
    func setupObservers() {

        query
            .deliverOn(Queue.Background)
            .map { query -> DocumentData in
                if query.keys.count == 1 && query.keys.first == "" {
                    return [:]
                }
                return query
            }
            .map { query -> [MongoDocument] in
                print(query)
                let limit = self.limit.value
                guard let docs = try? self.collection.find(query, limit: limit) else {
                    return []
                }

                return docs
            }
            .deliverOn(Queue.Main)
            .bindTo(documents)

        documents
            .deliverOn(Queue.Background)
            .map {
                $0.map { $0.data }
            }
            .map { (data: [DocumentData]) -> DocumentTreeData in
                DocumentTreeData(item: data)
            }
            .deliverOn(Queue.Main)
            .bindTo(treeData)
    }
}
