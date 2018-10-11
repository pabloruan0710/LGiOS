//
//  LoginService.swift
//  LG Atividades
//
//  Created by Pablo Ruan on 11/10/18.
//  Copyright © 2018 pabloruan. All rights reserved.
//

import Alamofire
import UIKit
import RealmSwift

enum Endpoint : String {
    case login = "http://doups.com.br:3011/login"
}


struct APIRequest {
    static func login(email:String, senha:String, handler: @escaping ((_ isLogged:Bool, _ msg:String)->Void)){
        Alamofire.request(Endpoint.login.rawValue, method: .post, parameters: ["email":email, "senha":senha], encoding: JSONEncoding.default, headers: nil)
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    guard let ret = value as? Dictionary<String,String> else {
                        handler(false, "Algo de errado ao efetuar login, cheque sua conexão e tente novamente.")
                        return
                    }
                    guard let msg = ret["msg"] else {return}
                    if let email = ret["email"]{
                        let usuario = Usuario()
                        usuario.id = 1
                        usuario.email = email
                        usuario.logado = true
                        if let nome = ret["nome"] { usuario.nome = nome}
                        
                        let realm = try! Realm()
                        try! realm.write({
                            realm.create(Usuario.self, value: usuario, update: true)
                        })
                        handler(true, msg)
                    }else{
                        handler(false, msg)
                    }
                case .failure(let er):
                    handler(false, er.localizedDescription ?? "x2: Algo de errado ao efetuar login, cheque sua conexão e tente novamente.")
                }
                
        }
    }
}
