//
//  Usuario.swift
//  LG Atividades
//
//  Created by Pablo Ruan on 10/10/18.
//  Copyright © 2018 pabloruan. All rights reserved.
//

import RealmSwift

@objcMembers
class Usuario : Object {
    
    dynamic var id:Int64 = 1
    dynamic var nome:String = ""
    dynamic var logado:Bool = false
    dynamic var email:String = ""
    
    override static func primaryKey()->String?{
        return "id"
    }
    
}
