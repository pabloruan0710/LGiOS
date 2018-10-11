//
//  DetalheAtividadeTableViewCell.swift
//  LG Atividades
//
//  Created by Pablo Ruan on 11/10/18.
//  Copyright © 2018 pabloruan. All rights reserved.
//

import UIKit

class DetalheAtividadeTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitulo: UILabel!
    @IBOutlet weak var lbDescricao: UILabel!
    @IBOutlet weak var lbDataHoraAtual: UILabel!
    @IBOutlet weak var lbIdioma: UILabel!
    
    class func loadNib()->UINib{
        return UINib(nibName: "DetalheAtividadeTableViewCell", bundle: nil)
    }
    class func identifier()->String{
        return "DetalheAtividadeTableViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCellDetalhe(atividade:Atividade){
        lbTitulo.text = atividade.nome
        lbDescricao.text = atividade.descricao
        let idioma = Locale.current.languageCode
        lbIdioma.text = idioma
        let utcDate = Date()
        lbDataHoraAtual.text = utcDate.description(with: Locale.current)
    }
    
}
