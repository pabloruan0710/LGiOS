//
//  DemoData.swift
//  LG Atividades
//
//  Created by Pablo Ruan on 11/10/18.
//  Copyright © 2018 pabloruan. All rights reserved.
//

import RealmSwift



func demoData(){
    let realm = try! Realm()
    let atividades = realm.objects(Atividade.self)
    try! realm.write {
        realm.delete(atividades)
    }
    for i in 1...20 {
        let atividade = Atividade()
        atividade.nome = "Atividade Número "+i.description
        atividade.descricao = "DESCRIÇÃO ATIVIDADE NUMERO: \(i.description)\n\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        atividade.dataHora = Date()
        atividade.visualizado = false
        atividade.addAtividade()
    }
}

