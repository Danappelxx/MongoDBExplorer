//
//  DatabaseTableViewCell.swift
//  MongoDBExplorer
//
//  Created by Dan Appel on 11/15/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import UIKit

class DatabaseTableViewCell: UITableViewCell {

    var databaseName: String {
        get {
            return databaseNameLabel.text ?? ""
        }
        set {
            databaseNameLabel.text = newValue
        }
    }

    @IBOutlet weak var databaseNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
