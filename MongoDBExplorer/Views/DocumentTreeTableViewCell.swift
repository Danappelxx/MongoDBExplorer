//
//  DocumentTreeTableViewCell.swift
//  MongoDBExplorer
//
//  Created by Dan Appel on 11/15/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import UIKit
import SnapKit

class DocumentTreeTableViewCell: UITableViewCell {

    var colors: Bool = false

    var level: Int = 0 {
        didSet {

            let offset = CGFloat(30 * level)
            self.label.snp_updateConstraints { make in
                make.leftMargin.equalTo(offset)
            }

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

    var labelText: String {
        get {
            return self.label!.text ?? ""
        }
        set {
            self.label!.text = newValue
        }
    }

    var label: UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        label = UILabel(frame: self.frame)
        self.addSubview(label)

        self.label.snp_makeConstraints { make in
            make.leftMargin.equalTo(0)
            make.centerY.equalTo(self)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
