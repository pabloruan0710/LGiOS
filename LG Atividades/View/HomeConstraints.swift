//
//  HomeConstraints.swift
//  LG Atividades
//
//  Created by Pablo Ruan on 11/10/18.
//  Copyright © 2018 pabloruan. All rights reserved.
//

import UIKit

extension HomeViewController {
    func setupConstraints(){
        self.view.addSubview(tableView)
        
        // set scroll autoLayout
        if #available(iOS 9.0, *) {
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
            
        } else {
            // tableView
            NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
            
        }
    }
}
