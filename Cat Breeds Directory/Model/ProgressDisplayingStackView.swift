//
//  ProgressDisplayingStackView.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 19.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import UIKit

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
    
    private let noInfoLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.noInfoString
        return label
    }()
    
    
    func displayVauesFom1To5(value: Int?) -> UIStackView {
        
        let stackView = createCustomStackView()
        let progressView = UIProgressView()
        
        guard let value = value else {
            stackView.addArrangedSubview(noInfoLabel)
            return stackView
        }
        progressView.setProgress(setValueToProgressView(value: value), animated: false)
        stackView.addArrangedSubview(label0)
        stackView.addArrangedSubview(progressView)
        stackView.addArrangedSubview(label5)
        return stackView
    }
    
    private func setValueToProgressView(value: Int) -> Float {
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
