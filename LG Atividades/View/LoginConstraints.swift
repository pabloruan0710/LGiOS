//
//  LoginConstraints.swift
//  LG Atividades
//
//  Created by Pablo Ruan on 11/10/18.
//  Copyright © 2018 pabloruan. All rights reserved.
//


import UIKit
extension LoginViewController {
    
    func setupConstraints(){
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentTextFields)
        self.contentTextFields.addSubview(txtEmail)
        self.contentTextFields.addSubview(txtSenha)
        self.scrollView.addSubview(btEntrar)
        self.scrollView.addSubview(btGoogle)
        
        // set scroll autoLayout
        if #available(iOS 9.0, *) {
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
            scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
            scrollView.heightAnchor.constraint(equalToConstant: self.view.frame.height+200).isActive = true
            scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
            
            contentTextFields.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
            contentTextFields.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -70).isActive = true
            contentTextFields.heightAnchor.constraint(equalToConstant: 160).isActive = true
            contentTextFields.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
            
            txtEmail.topAnchor.constraint(equalTo: self.contentTextFields.topAnchor, constant: 20).isActive = true
            txtEmail.leftAnchor.constraint(equalTo: self.contentTextFields.leftAnchor, constant: 4).isActive = true
            txtEmail.rightAnchor.constraint(equalTo: self.contentTextFields.rightAnchor, constant: -4).isActive = true
            txtEmail.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            txtSenha.topAnchor.constraint(equalTo: self.txtEmail.bottomAnchor, constant: 20).isActive = true
            txtSenha.leftAnchor.constraint(equalTo: self.contentTextFields.leftAnchor, constant: 4).isActive = true
            txtSenha.rightAnchor.constraint(equalTo: self.contentTextFields.rightAnchor, constant: -4).isActive = true
            txtSenha.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            btEntrar.topAnchor.constraint(equalTo: self.contentTextFields.bottomAnchor, constant: 10).isActive = true
            btEntrar.widthAnchor.constraint(equalTo: contentTextFields.widthAnchor, constant: -8).isActive = true
            btEntrar.heightAnchor.constraint(equalToConstant: 50).isActive = true
            btEntrar.centerXAnchor.constraint(equalTo: self.contentTextFields.centerXAnchor, constant: 0).isActive = true
            
            btGoogle.topAnchor.constraint(equalTo: self.btEntrar.bottomAnchor, constant: 10).isActive = true
            btGoogle.widthAnchor.constraint(equalTo: contentTextFields.widthAnchor).isActive = true
            btGoogle.heightAnchor.constraint(equalToConstant: 50).isActive = true
            btGoogle.centerXAnchor.constraint(equalTo: self.contentTextFields.centerXAnchor, constant: 0).isActive = true
            
        } else {
            // scrollView
            NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: scrollView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: scrollView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: scrollView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.2, constant: 0).isActive = true
            
            NSLayoutConstraint(item: contentTextFields, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: contentTextFields, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: -50).isActive = true
            NSLayoutConstraint(item: contentTextFields, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.0, constant: 160).isActive = true
            NSLayoutConstraint(item: contentTextFields, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.8, constant: 0).isActive = true
            
            NSLayoutConstraint(item: txtEmail, attribute: .top, relatedBy: .equal, toItem: self.contentTextFields, attribute: .top, multiplier: 1.0, constant: 20).isActive = true
            NSLayoutConstraint(item: txtEmail, attribute: .left, relatedBy: .equal, toItem: self.contentTextFields, attribute: .left, multiplier: 1.0, constant: 4).isActive = true
            NSLayoutConstraint(item: txtEmail, attribute: .right, relatedBy: .equal, toItem: self.contentTextFields, attribute: .right, multiplier: 1.0, constant: -4).isActive = true
            NSLayoutConstraint(item: txtEmail, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 50).isActive = true
            
            NSLayoutConstraint(item: txtSenha, attribute: .top, relatedBy: .equal, toItem: self.txtEmail, attribute: .bottom, multiplier: 1.0, constant: 20).isActive = true
            NSLayoutConstraint(item: txtSenha, attribute: .left, relatedBy: .equal, toItem: self.contentTextFields, attribute: .left, multiplier: 1.0, constant: 4).isActive = true
            NSLayoutConstraint(item: txtSenha, attribute: .right, relatedBy: .equal, toItem: self.contentTextFields, attribute: .right, multiplier: 1.0, constant: -4).isActive = true
            NSLayoutConstraint(item: txtSenha, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 50).isActive = true
            
            NSLayoutConstraint(item: btEntrar, attribute: .top, relatedBy: .equal, toItem: self.contentTextFields, attribute: .bottom, multiplier: 1.0, constant: 10).isActive = true
            NSLayoutConstraint(item: btEntrar, attribute: .width, relatedBy: .equal, toItem: self.contentTextFields, attribute: .width, multiplier: 1.0, constant: 4).isActive = true
            NSLayoutConstraint(item: btEntrar, attribute: .centerX, relatedBy: .equal, toItem: self.contentTextFields, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: btEntrar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 50).isActive = true
            
            NSLayoutConstraint(item: btGoogle, attribute: .top, relatedBy: .equal, toItem: self.btEntrar, attribute: .bottom, multiplier: 1.0, constant: 10).isActive = true
            NSLayoutConstraint(item: btGoogle, attribute: .width, relatedBy: .equal, toItem: self.contentTextFields, attribute: .width, multiplier: 1.0, constant: 4).isActive = true
            NSLayoutConstraint(item: btGoogle, attribute: .centerX, relatedBy: .equal, toItem: self.contentTextFields, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: btGoogle, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 50).isActive = true
        }
        
    }
}
