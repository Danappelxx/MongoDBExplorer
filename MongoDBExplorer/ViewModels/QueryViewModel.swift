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
    let limitString = Observable(String?(""))
    let limitIsValid = Observable(false)
    let limit = Observable(Int())

    let keyString = Observable(String?(""))
    let valueString = Observable(String?(""))
    let keyValueFormattedString = Observable("")

    let queryTuple = Observable("","")
    let query: Observable<[String:String]> = Observable([:])

    init(initialQuery: [String:String], initialLimit: Int) {

        setupQuery(query: initialQuery)
        setupLimit(limit: initialLimit)
    }
    
    func setupQuery(query query: [String:String]) {
        let key: String
        let value: String
        if query != [:] {
            key = query.keys.first!
            value = query[key]!
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
            .bindTo(self.query)
        
        queryTuple
            .map { key, value in
                "[ \(key) : \(value) ]"
            }
            .bindTo(keyValueFormattedString)
    }
    
    func setupLimit(limit limit: Int) {
        let limitValue = Observable(Int?())
        
        limitString
            .map { str -> String in
                guard let str = str else { return "0" } // nil string
                guard str != "" else { return "0" } // blank string
                return str
            }
            .map { Int($0) } // Int?
            .bindTo(limitValue)
        
        limitValue
            .map { (val: Int?) -> Bool in
                guard let val = val else { return false }
                guard val >= 0 else { return false }
                
                return true
            }
            .bindTo(limitIsValid)
        
        limitIsValid
            .filter { $0 }
            .map { _ in limitValue.value! }
            .bindTo(self.limit)
        
        limitString.next(String(limit))
    }
}
