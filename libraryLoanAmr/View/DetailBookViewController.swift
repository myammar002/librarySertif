//
//  DetailBookViewController.swift
//  libraryLoanAmr
//
//  Created by Ammar on 08/05/22.
//

import UIKit

class DetailBookViewController: UIViewController {

    @IBOutlet weak var btnChoose: UIButton!
    @IBOutlet weak var judul_text: UITextField!
    @IBOutlet weak var tahun_text: UITextField!
    @IBOutlet weak var penulis_text: UITextField!
    @IBOutlet weak var imageBook: UIImageView!
    
    var dBook : ResponseBuku?
    var idBuku = ""
    override func viewDidLoad() {
        btnChoose.isHidden = true
        super.viewDidLoad()
        judul_text.text = dBook?.nama_buku
        tahun_text.text = dBook?.tahun_rilis
        penulis_text.text = dBook?.penulis
        let url = URL(string: dBook!.gambar_buku)
        if let data = try? Data(contentsOf: url!) {
            let image: UIImage = UIImage(data: data)!
            imageBook.image = image
        }
          
    }
    

    @IBAction func btnUpdate(_ sender: UIButton) {
        if judul_text.text != "" && tahun_text.text != "" && penulis_text.text != "" {
            let judul = judul_text.text
            let tahun = tahun_text.text
            let penulis = penulis_text.text
          //  let gambar = url
            //  Connection with web server passing the values with POST
             let request = NSMutableURLRequest(url: NSURL(string: "https://yashcollection.000webhostapp.com/library-update-buku.php")! as URL)
             request.httpMethod = "POST"

             // Collect value
            let postString = "nama=\(judul!)&tahun=\(tahun!)&penulis=\(penulis!)&id=\(idBuku)"
             // Encoding the text values in UTF8
             request.httpBody = postString.data(using: String.Encoding.utf8)

             // Session to share value and get the response
             let task = URLSession.shared.dataTask(with: request as URLRequest) {
                 data, response, error in

                 if error != nil {
                     print("error=\(String(describing: error))")
                     return
                 }

                 print("response = \(String(describing: error))")

                 let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                 print("responseString= \(String(describing: responseString))")
             }
             task.resume()
            let alertController = UIAlertController(title: "Succesfully", message: "Buku Ditambahkan", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {action in
                self.navigationController?.popViewController(animated: true)
    }))
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Unsuccesfully", message: "Pastikan semua data sudah diisi", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
