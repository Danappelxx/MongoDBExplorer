//
//  DocumentTreeTableViewCell.swift
//  MongoDBExplorer
//
//  Created by Dan Appel on 11/15/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import UIKit

class DocumentTreeTableViewCell: UITableViewCell {

    var colors: Bool = false

    var level: Int = 0 {
        didSet {

            let offset = CGFloat(30 * level)
            self.leadingMarginConstraint.constant = -offset

            if colors {
                let red: CGFloat = 70
                let green: CGFloat = 152 + CGFloat(level * 15)
                let blue: CGFloat = 219 - CGFloat(level * 15)
                let alpha: CGFloat = 0.5

                let backgroundColor = UIColor(red: (1/255)*red, green: (1/255)*green, blue: (1/255)*blue, alpha: alpha)
                self.backgroundColor = backgroundColor
            }
        }
    }

    var label: String {
        get {
            return labelLabel.text ?? ""
        }
        set {
            labelLabel.text = newValue
        }
    }

    @IBOutlet weak var labelLabel: UILabel!
    @IBOutlet weak var leadingMarginConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
