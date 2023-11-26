//
//  DetalleLibroViewController.swift
//  CL3-Madrid
//
//  Created by DAMII on 20/11/23.
//

import UIKit
import Kingfisher

class DetalleLibroViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblSubtitle: UILabel!
    
    @IBOutlet weak var llblIsbn: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblURL: UILabel!
    
    
    var bean:Book!
    
    @IBOutlet weak var imgFotito: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        lblTitle.text=bean.title
        lblSubtitle.text = bean.subtitle
        llblIsbn.text = bean.isbn13
        lblPrice.text = bean.price
        lblURL.text = bean.url
        
            let url = URL(string: bean.image)
            imgFotito.kf.setImage(with: url)

    }
    


}
