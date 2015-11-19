//
//  QueryViewModel.swift
//  MongoDBExplorer
//
//  Created by Dan Appel on 11/18/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import Foundation
import Bond

class QueryViewModel {
    let keyString = Observable(String?(""))
    let valueString = Observable(String?(""))
    let keyValueFormattedString = Observable("")

    let queryTuple = Observable("","")
    let query: Observable<[String:String]> = Observable([:])

    init(initialQuery: [String:String]) {

        let key: String
        let value: String
        if initialQuery != [:] {
            key = initialQuery.keys.first!
            value = initialQuery[key]!
        } else {
            key = ""
            value = ""
        }

        keyString
            .next(key)
        valueString
            .next(value)


        keyString
            .map { $0 ?? "" }
            .combineLatestWith(valueString.map { $0 ?? "" })
            .bindTo(queryTuple)

        queryTuple
            .map { key, value in
                [key : value]
            }
            .bindTo(query)
        
        queryTuple
            .map { key, value in
                "[ \(key) : \(value) ]"
            }
            .bindTo(keyValueFormattedString)
    }
}
