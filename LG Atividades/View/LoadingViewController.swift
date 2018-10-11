//
//  LoadingViewController.swift
//  LG Atividades
//
//  Created by Pablo Ruan on 11/10/18.
//  Copyright © 2018 pabloruan. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    private var opacidade : CGFloat!
    init(opacidade : CGFloat = 0.49){
        super.init(nibName: "LoadingViewController", bundle: nil)
        self.opacidade = opacidade
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(opacidade)
        NotificationCenter.default.addObserver(self, selector: #selector(removeView), name: NSNotification.Name(rawValue: "remove_loading"), object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.5, animations: {
            self.view.alpha = 0
        }) { (fim) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func removeView(){
        
        UIView.animate(withDuration: 0.1, animations: {
            self.view.alpha = 0
        }) { (fim) in
            self.dismiss(animated: false, completion: nil)
        }
    }
}

extension UIViewController {
    
    func showLoading(opacidade:CGFloat=0.59){
        self.hiddenLoading()
        DispatchQueue.main.async {
            let vc = LoadingViewController(opacidade: opacidade)
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: false, completion: nil)
        }
    }
    func hiddenLoading(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "remove_loading"), object: nil)
    }
}
