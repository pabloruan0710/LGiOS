//
//  LoginViewController.swift
//  LG Atividades
//
//  Created by Pablo Ruan on 10/10/18.
//  Copyright © 2018 pabloruan. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {

    var scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        //scroll.backgroundColor = .yellow
        return scroll
    }()
    var contentTextFields : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .red
        return view
    }()
    let txtEmail: UITextField = {
        let txt = UITextField()
        txt.backgroundColor = .white
        txt.borderStyle = .roundedRect
        txt.layer.cornerRadius = 3
        txt.placeholder = "Login: demo@demo.com"
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.autocapitalizationType = .none
        return txt
    }()
    let txtSenha: UITextField = {
        let txt = UITextField()
        txt.backgroundColor = .white
        txt.borderStyle = .roundedRect
        txt.layer.cornerRadius = 3
        txt.placeholder = "Senha: 123"
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.isSecureTextEntry = true
        return txt
    }()
    
    let btEntrar : UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.clipsToBounds = true
        bt.layer.cornerRadius = 4
        bt.setTitle("Entrar", for: .normal)
        bt.backgroundColor = UIColor.green
        bt.setTitleColor(.white, for: .normal)
        bt.addTarget(self, action: #selector(loginAPI), for: .touchUpInside)
        return bt
    }()
    
    
    
    let btGoogle : GIDSignInButton = {
        let bt = GIDSignInButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(loginGoogle), for: .touchUpInside)
        return bt
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupConstraints()
        self.setupDelegateGID()
        self.txtSenha.delegate = self
        self.txtEmail.delegate = self
    }

}


// MARK: GoogleLogin
extension LoginViewController : GIDSignInUIDelegate {
    func setupDelegateGID(){
        // delegate for google login
        GIDSignIn.sharedInstance()?.uiDelegate = self
        //GIDSignIn.sharedInstance()?.signIn()
    }
    @objc func loginGoogle(){
        self.showLoading()
    }
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.hiddenLoading()
    }
    
    @objc func loginAPI(){
        guard let email = txtEmail.text, email != "" else {
            self.alert(titulo: "Atenção", mensagem: "Preencha o campo de email!")
            return
        }
        guard let senha = txtSenha.text, senha != "" else {
            self.alert(titulo: "Atenção", mensagem: "Preencha o campo de senha!")
            return
        }
        self.showLoading()
        APIRequest.login(email: email, senha: senha) { (logged, msg) in
            self.hiddenLoading()
            if logged {
                demoData()
                let vc = HomeViewController()
                vc.title = "Atividades"
                let nav = UINavigationController(rootViewController: vc)
                UIApplication.shared.keyWindow?.rootViewController = nav
            }else{
                DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
                    self.alert(titulo: "Atenção", mensagem: msg)
                })
            }
        }
    }
}


extension LoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == txtEmail){
            self.txtSenha.becomeFirstResponder()
        }else{
            self.view.endEditing(true)
        }
        return true
    }
}
