//
//  ProgressDisplayingStackView.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 19.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import UIKit
///Prepare stack view with all set child elements to display number as UIProgressView
final class ProgressDisplayingStackView {
    
    private var stackView: UIStackView?
    private var label0: UILabel {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }
    
    private var label5: UILabel {
        let label = UILabel()
        label.text = "5"
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }
    ///Label to display in case number value = nil
    private let noInfoLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.noInfoString
        return label
    }()
    
    ///Append prepared children to UIStackView .
    ///
    ///In case value is nil, label with no info text append to the stack.
    ///Otherwise prepared labels and setup progress view appends to the stack.
    ///- Parameters:
    ///    - value: `Int` from 0 to 5
    func displayVauesFom1To5(value: Int?) -> UIStackView {
        
        let stackView = createCustomStackView()
        let progressView = UIProgressView()
        
        guard let value = value else {
            stackView.addArrangedSubview(noInfoLabel)
            return stackView
        }
        progressView.setProgress(prepareValueForProgressView(value: value), animated: false)
        stackView.addArrangedSubview(label0)
        stackView.addArrangedSubview(progressView)
        stackView.addArrangedSubview(label5)
        return stackView
    }
    ///Prepare Float value
    private func prepareValueForProgressView(value: Int) -> Float {
        let result = IntDecimal(intFrom0To5: value)
        return result.value
    }
    
    private func createCustomStackView() -> UIStackView {
        let stackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .center
            stack.spacing = 8
            return stack
        }()
        return stackView
    }

}
