//
//  CollectionsTableViewCell.swift
//  MongoDBExplorer
//
//  Created by Dan Appel on 11/15/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import UIKit

class CollectionsTableViewCell: UITableViewCell {

    var collectionName: String {
        get {
            return collectionNameLabel.text ?? ""
        }
        set {
            collectionNameLabel.text = newValue
        }
    }

    @IBOutlet weak var collectionNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
