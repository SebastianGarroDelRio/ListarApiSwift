//
//  ConsultarViewController.swift
//  CL3-Madrid
//
//  Created by DAMII on 21/11/23.
//

import UIKit
import Alamofire
import Toaster
import Kingfisher
import FirebaseFirestore

class ConsultarViewController: UIViewController {

    
    var api: [Api] = []
    
    @IBOutlet weak var txtISBN13: UITextField!
    @IBOutlet weak var imgFoto: UIImageView!
    @IBOutlet weak var lblChapter2: UILabel!
    @IBOutlet weak var lblChapter1: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblPages: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblAuthors: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblTItle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    @IBAction func btnConsultar(_ sender: UIButton) {
        let ibn13 = txtISBN13.text ?? ""
        
        // Realizar la solicitud HTTP a la API
        let request = AF.request("https://api.itbook.store/1.0/books/\(ibn13)")
        
        // Decodificar los datos JSON
        request.responseDecodable(of: Api.self) { response in
            if let api = response.value {
                // El libro existe
                
                // Mostrar los datos del libro
                self.lblTItle.text = api.title
                self.lblSubtitle.text = api.subtitle
                self.lblAuthors.text = api.authors
                self.lblYear.text = api.year
                self.lblPages.text = api.pages
                self.lblLanguage.text = api.language
                self.lblPrice.text = api.price
                
                // Cargar la imagen del libro
                let url = URL(string: api.image)
                self.imgFoto.kf.setImage(with: url)
            } else {
                // El libro no existe
                Toast(text: "Libro no encontrado").show()
                self.lblTItle.text = ""
                self.lblSubtitle.text = ""
                self.lblAuthors.text = ""
                self.lblYear.text = ""
                self.lblPages.text = ""
                self.lblLanguage.text = ""
                self.lblPrice.text = ""
            }
            
            
        }

        
        
        
    }


    
    
    
    
    

}
