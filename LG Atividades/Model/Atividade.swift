//
//  Atividade.swift
//  LG Atividades
//
//  Created by Pablo Ruan on 10/10/18.
//  Copyright © 2018 pabloruan. All rights reserved.
//

import RealmSwift

@objcMembers
class Atividade : Object {
    
    dynamic var id:Int = 0
    dynamic var nome:String = ""
    dynamic var visualizado:Bool = false
    dynamic var descricao : String = ""
    dynamic var dataHora : Date = Date()
    
    override static func primaryKey()->String? {
        return "id"
    }
    
    // gerando id (Realm não possui autoincrement)
    private func generateID()->Int{
        let realm = try! Realm()
        guard let lastID = realm.objects(Atividade.self).last else {
            return 1
        }
        return lastID.id+1
    }
    
    // criar uma nova atividade
    func addAtividade(){
        let realm = try! Realm()
        self.id = self.generateID()
        do {
            try realm.write {
                realm.create(Atividade.self, value: self, update: true)
            }
        }catch (_){
            fatalError("Check Space your device! ")
        }
    }
    
    // retorna detalhe de uma atividade
    static func detalheAtividade(_ idAtividade:Int)->Atividade?{
        let realm = try! Realm()
        return realm.object(ofType: Atividade.self, forPrimaryKey: idAtividade)
    }
}
