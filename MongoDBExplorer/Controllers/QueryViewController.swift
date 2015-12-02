//
//  QueryViewController.swift
//  MongoDBExplorer
//
//  Created by Dan Appel on 11/18/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import UIKit
import SnapKit

class QueryViewController: UIViewController {

    weak var delegate: QueryDelegate?

    @IBOutlet weak var limitField: UITextField!
    @IBOutlet weak var keyField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!

    @IBOutlet weak var keyValueFieldsStack: UIStackView!

    @IBOutlet weak var keyValueLabel: UILabel!

    var viewModel: QueryViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupConstraints()
        setupObservers()
    }

    func setupConstraints() {

        keyField.snp_makeConstraints { make in
            make.width.equalTo(100)
            make.width.equalTo(valueField.snp_width)
        }

        keyValueFieldsStack.snp_makeConstraints { make in
            make.center.equalTo(self.view.snp_center)
        }
        keyValueFieldsStack.spacing = 10


        keyValueLabel.snp_makeConstraints { make in
            make.centerX.equalTo(keyValueFieldsStack.snp_centerX)
            make.centerY.equalTo(keyValueFieldsStack.snp_centerY).offset(40)
            make.width.equalTo(self.view)
        }


        limitField.snp_makeConstraints { make in
            make.centerX.equalTo(keyValueFieldsStack.snp_centerX)
            make.centerY.equalTo(keyValueFieldsStack.snp_centerY).offset(-40)
        }

    }

    func setupObservers() {

        viewModel.keyString
            .bidirectionalBindTo(keyField.bnd_text)
        viewModel.valueString
            .bidirectionalBindTo(valueField.bnd_text)

        viewModel.keyValueFormattedString
            .bindTo(keyValueLabel.bnd_text)

        viewModel.limitString
            .bidirectionalBindTo(limitField.bnd_text)

        let originalColor = limitField.backgroundColor
        viewModel.limitIsValid
            .observe {
                if !$0 {
                    self.limitField.backgroundColor = UIColor.redColor()
                } else {
                    self.limitField.backgroundColor = originalColor
                }
            }
        viewModel.limitIsValid
            .bindTo(doneButton.bnd_enabled)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doneTapped(sender: AnyObject) {
        delegate?.update(limit: viewModel.limit.value, query: viewModel.query.value)

        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func cancelTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}

import SwiftMongoDB
protocol QueryDelegate: class {
    func update(limit limit: Int, query: DocumentData)
}
