//
//  DetalheAtividadeViewController.swift
//  LG Atividades
//
//  Created by Pablo Ruan on 11/10/18.
//  Copyright © 2018 pabloruan. All rights reserved.
//

import UIKit
import RealmSwift

class DetalheAtividadeViewController: UIViewController {

    lazy var tableView : UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.delegate = self
        tb.dataSource = self
        tb.tableFooterView = UIView()
        return tb
    }()
    
    var idAtividade: Int!
    var atividade:Atividade?
    
    init(idAtividade:Int){
        super.init(nibName: nil, bundle: nil)
        self.idAtividade = idAtividade
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGray
        self.setupConstraints()
        self.registerCell()
        self.initDataRealm()
    }
    
    
    func initDataRealm(){
        let realm = try! Realm()
        atividade = realm.object(ofType: Atividade.self, forPrimaryKey: self.idAtividade)
        // marcar como visualizado
        try! realm.write {
            atividade?.visualizado = true
        }
    }
    
    
    func registerCell(){
        self.tableView.register(DetalheAtividadeTableViewCell.loadNib(), forCellReuseIdentifier: DetalheAtividadeTableViewCell.identifier())
    }
}



extension DetalheAtividadeViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetalheAtividadeTableViewCell.identifier()) as! DetalheAtividadeTableViewCell
        guard let _ = atividade else {return cell}
        cell.setupCellDetalhe(atividade: atividade!)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
}
