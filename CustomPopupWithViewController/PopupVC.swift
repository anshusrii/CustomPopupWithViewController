//
//  PopupVC.swift
//  CustomPopupWithViewController
//
//  Created by Sudhanshu Sudhanshu on 20/07/18.
//  Copyright © 2018 Sudhanshu Sudhanshu. All rights reserved.
//

import UIKit

class PopupVC: UIViewController {

    var stackView : UIStackView = {
        
        let buttonTitles = ["Dynamic Button 1", "Dynamic Button 2", "Dynamic Button 3"]
        
        let buttons : [UIButton] = buttonTitles.map({ (title) -> UIButton in
            let button1 = UIButton(type: .custom)
            button1.setTitle(title, for: .normal)
            button1.layer.backgroundColor = UIColor.white.cgColor
            button1.setTitleColor(.blue, for: .normal)
            return button1
        })
        
        let optionStackView = UIStackView(arrangedSubviews: buttons)
        optionStackView.spacing = 0.5
        optionStackView.axis = .vertical
        optionStackView.alignment = .fill
        optionStackView.distribution = .fill
        
        let cancelButton = UIButton(type: .custom)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.layer.backgroundColor = UIColor.white.cgColor
        cancelButton.layer.cornerRadius = 8
        cancelButton.setTitleColor(.blue, for: .normal)
        
        let stackView = UIStackView(arrangedSubviews: [optionStackView, cancelButton])
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    fileprivate func prepareOptionsUI() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let leftConstraint = NSLayoutConstraint(item: stackView, attribute: .leftMargin, relatedBy: .equal, toItem: view, attribute: .leftMargin, multiplier: 1, constant: 0)
        
        let rightConstraint = NSLayoutConstraint(item: stackView, attribute: .rightMargin, relatedBy: .equal, toItem: view, attribute: .rightMargin, multiplier: 1, constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(item: stackView, attribute: .bottomMargin, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1, constant: 100)
        NSLayoutConstraint.activate([leftConstraint, rightConstraint, bottomConstraint])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareOptionsUI()
        
        perform(#selector(showOptions), with: nil, afterDelay: 0.1)
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        view.addGestureRecognizer(tapGR)
    }
    
    
    @objc fileprivate func showOptions() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.constraints.forEach({ (constraint) in
                if constraint.firstAttribute == .bottomMargin {
                    constraint.constant = -1
                }
            })
            
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func tapHandler () {
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        
            self.view.constraints.forEach({ (constraint) in
                if constraint.firstAttribute == .bottomMargin {
                    constraint.constant = 100
                }
            })
            
            self.view.layoutIfNeeded()
        }, completion:{ _ in
            self.dismiss(animated: true)
        })
    }
}
