//
//  HomeViewController.swift
//  LG Atividades
//
//  Created by Pablo Ruan on 10/10/18.
//  Copyright © 2018 pabloruan. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

class HomeViewController: UIViewController {

    lazy var tableView : UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.delegate = self
        tb.dataSource = self
        tb.tableFooterView = UIView()
        tb.addSubview(push)
        return tb
    }()
    lazy var push : UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.addDemoData), for: .valueChanged)
        return refresh
    }()
    lazy var searchBar = UISearchBar(frame: .zero)
    
    // dataInit
    var atividades : Results<Atividade>!
    
    var originalTitleView : UIView?
    var token:NotificationToken?
    var isSearch:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        self.setupConstraints()
        self.setupSearchButton()
        self.registerCell()
        self.initDataRealm()
    }
    deinit {
        self.token?.invalidate()
    }
    
 
    
    func initDataRealm(){
        let realm = try! Realm()
        atividades = realm.objects(Atividade.self)
        token = atividades.observe({ [weak self](changes) in
            guard let mySelf = self else {return}
            mySelf.tableView.reloadData()
        })
    }
    
    func registerCell(){
        self.tableView.register(AtividadeTableViewCell.loadNib(), forCellReuseIdentifier: AtividadeTableViewCell.identifier())
    }
    
    func setupSearchButton(){
        let barButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(self.initPesquisarAtividades))
        let add = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.addDemoData))
        self.navigationItem.rightBarButtonItems = [add, barButton]
        originalTitleView = self.navigationController?.navigationBar.topItem?.titleView
        
        let sair = UIBarButtonItem(title: "Sair", style: .done, target: self, action: #selector(self.exitLogin))
        self.navigationItem.leftBarButtonItem = sair
    }
    
    @objc func addDemoData(){
        self.push.beginRefreshing()
        demoData()
        DispatchQueue.main.async {
            self.push.endRefreshing()
        }
    }
    
    @objc func exitLogin(){
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let realm = try Realm()
            let usuarios = realm.objects(Usuario.self)
            let atividadesRemove = realm.objects(Atividade.self)
            try! realm.write {
                for user in usuarios {
                    user.logado = false
                }
                realm.delete(atividadesRemove)
            }
            
            let vc = LoginViewController()
            vc.title = "Login"
            let nav = UINavigationController(rootViewController: vc)
            UIApplication.shared.keyWindow?.rootViewController = nav
            
        } catch let signOutError as NSError {
            print ("Erro ao fazer logout : %@", signOutError)
        }
    }
    
}




extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if atividades == nil {
            return 0
        }
        return atividades.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AtividadeTableViewCell.identifier()) as! AtividadeTableViewCell
        cell.setupCell(atividade: atividades[indexPath.row])
        return cell
     }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vcDetail = DetalheAtividadeViewController(idAtividade: atividades[indexPath.row].id)
        self.navigationController?.pushViewController(vcDetail, animated: true)
    }
}


extension HomeViewController: UISearchBarDelegate {
    @objc func initPesquisarAtividades(){
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.sizeToFit()
        searchBar.placeholder = ""
        UIView.animate(withDuration: 0.5) {
            self.navigationController?.navigationBar.topItem?.titleView = self.searchBar
            self.isSearch = true
        }
        searchBar.becomeFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let textSearch: NSString = (searchBar.text ?? "") as NSString
        let textFinally = textSearch.replacingCharacters(in: range, with: text)
        
        if textFinally == ""{
            returnAll()
            return true
        }
        
        self.pesquisarAtividade(text: textFinally)
        return true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        if let text = searchBar.text, text != " "{
            self.pesquisarAtividade(text: text)
        }
    }
    
    func pesquisarAtividade(text:String){
        let realm = try! Realm()
        self.atividades = realm.objects(Atividade.self).filter("nome CONTAINS [cd] %@", text)
        self.tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isSearch = false
        self.view.endEditing(true)
        self.navigationController?.navigationBar.topItem?.titleView = originalTitleView
        returnAll()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            returnAll()
        }
    }
    
    func returnAll(){
        let realm = try! Realm()
        self.atividades = realm.objects(Atividade.self)
        self.tableView.reloadData()
    }
}
