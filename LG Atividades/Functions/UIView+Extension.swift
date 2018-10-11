//
//  UIView+Extension.swift
//  LG Atividades
//
//  Created by Pablo Ruan on 10/10/18.
//  Copyright © 2018 pabloruan. All rights reserved.
//

import UIKit


extension UIViewController {
    func alert(titulo:String, mensagem:String?){
        let UIAlert = UIAlertController(title:titulo, message: mensagem, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        UIAlert.addAction(actionOK)
        self.present(UIAlert, animated: true, completion: nil)
    }
}
