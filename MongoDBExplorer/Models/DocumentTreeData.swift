//
//  DocumentTreeData.swift
//  MongoDBExplorer
//
//  Created by Dan Appel on 11/15/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import Foundation
import SwiftMongoDB

struct DocumentTreeData {

    private (set) var children: [AnyObject]?

    init(item: AnyObject!) {

        if item == nil {
            self.children = nil
            return
        }

        if let data = item as? DocumentData {
            let keys = [String](data.keys)

            if keys.count == 1 {
                self.children = [data[keys[0]]!]
                return
            }

            let datas: [AnyObject] = keys.map { key in [key:data[key]!] }

            self.children = datas
            return
        }

        if let data = item as? [AnyObject] {
            self.children = data
        }
    }
}
