//
//  AddBookViewController.swift
//  libraryLoanAmr
//
//  Created by Ammar on 08/05/22.
//

import UIKit

class AddBookViewController: UIViewController {

    @IBOutlet weak var btnimage: UIButton!
    @IBOutlet weak var judul_textfield: UITextField!
    @IBOutlet weak var tahun_textfield: UITextField!
    @IBOutlet weak var penulis_textfield: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var url : String = ""
    
    weak var refreshDelegate : RefreshDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openImage(_ sender: UIButton) {
        showImagePickerOptions()
    }
    
    func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        return imagePicker
    }
    
    func showImagePickerOptions() {
        let alertVC = UIAlertController(title: "Pick a Photo", message: "Choose Picture", preferredStyle: .actionSheet)
        let libraryAction = UIAlertAction(title: "Library", style: .default) { [weak self] (action) in
            guard let self = self else {
                return
            }
            let libraryImagePicker = self.imagePicker(sourceType: .photoLibrary)
            libraryImagePicker.delegate = self
            self.present(libraryImagePicker, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertVC.addAction(libraryAction)
        alertVC.addAction(cancelAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        if judul_textfield.text != "" && tahun_textfield.text != "" && penulis_textfield.text != "" {
            let judul = judul_textfield.text
            let tahun = tahun_textfield.text
            let penulis = penulis_textfield.text
            let gambar = url
            //  Connection with web server passing the values with POST
             let request = NSMutableURLRequest(url: NSURL(string: "https://yashcollection.000webhostapp.com/library-add-buku.php")! as URL)
             request.httpMethod = "POST"

             // Collect value
            let postString = "nama=\(judul!)&tahun=\(tahun!)&penulis=\(penulis!)&gambar=\(gambar)"
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
                self.dismiss(animated: true, completion: { [self] in
                    refreshDelegate?.goLoad()
                } )
    }))
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Unsuccesfully", message: "Pastikan semua data sudah diisi", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
    
   
extension AddBookViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as! UIImage
            let imageURL = info[.imageURL] as? URL
            url = "\(String(describing: imageURL!.path))"
            self.imageView.image = image
            self.dismiss(animated: true, completion: nil)
        }
    
}
