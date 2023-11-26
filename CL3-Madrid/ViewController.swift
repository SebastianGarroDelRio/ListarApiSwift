//
//  ViewController.swift
//  CL3-Madrid
//
//  Created by DAMII on 18/11/23.
//

import UIKit
import Alamofire
import Kingfisher
import Toaster


class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var cvLibros: UICollectionView!
    
    
    @IBOutlet weak var txtLibro: UITextField!
    
    //
    var consulta:xd!

    var pos = -1
    var libro: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cvLibros.dataSource=self
        cvLibros.delegate=self

    }
    
    

    
    
    func buscar(titulo:String){
        AF.request("https://api.itbook.store/1.0/search/"+titulo).responseDecodable(of: xd.self){
            data in
            if(data.value != nil){
                if(data.value?.books.isEmpty != true){
                    self.consulta = data.value!
                    self.libro = self.consulta.books
                    self.cvLibros.reloadData()
                }else{
                    Toast(text: "No fue posible encontrar los libros").show()
                }
            }else{
                Toast(text: "No fue posible encontrar los libros").show()
            }
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return libro.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = collectionView.dequeueReusableCell(withReuseIdentifier: "row", for: indexPath) as! ItemCollectionViewCell
        
        let url = URL(string: libro[indexPath.row].image)
        row.imgFoto.kf.setImage(with: url)
        
        row.imgTitulo.text = libro[indexPath.row].title
        return row
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20)/2 // ancho
        return CGSize(width: width, height: 300)
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pos=indexPath.row
        performSegue(withIdentifier: "detalle", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="detalle"{
            let row=segue.destination as! DetalleLibroViewController
            //ACCEDER A BEAN
            row.bean=libro[pos]
        }
    }
    
    
    /*
    func cargarData() {
        AF.request("https://api.itbook.store/1.0/search/mongodb").responseDecodable(of: [Book].self) { data in
            guard let info = data.value else { return }
            self.libro = info
            self.cvLibros.reloadData()
        }
    }*/


    

    
    
    @IBAction func btnBuscar(_ sender: UIButton) {
        let titulo = txtLibro.text ?? ""
        cvLibros.dataSource = self
        cvLibros.delegate = self
        buscar(titulo: titulo)
        
    }
    
    

    
}

