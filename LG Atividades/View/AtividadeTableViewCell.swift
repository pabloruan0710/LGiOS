//
//  AtividadeTableViewCell.swift
//  LG Atividades
//
//  Created by Pablo Ruan on 11/10/18.
//  Copyright © 2018 pabloruan. All rights reserved.
//

import UIKit

class AtividadeTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lbNome: UILabel!
    @IBOutlet weak var lbIsRead: UILabel!
    
    
    class func loadNib()->UINib{
        return UINib(nibName: "AtividadeTableViewCell", bundle: nil)
    }
    class func identifier()->String{
        return "AtividadeTableViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(atividade:Atividade){
        lbNome.text = atividade.nome
        if atividade.visualizado {
            lbIsRead.isHidden = true
            lbNome.textColor = .gray
        }else{
            lbIsRead.isHidden = false
            lbNome.textColor = .black
        }
    }
    
}
