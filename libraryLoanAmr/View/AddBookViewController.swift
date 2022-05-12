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
    var userimg: String = ""
    var coreData = DatabaseHelper()
    
    weak var refreshDelegate : RefreshDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openImage(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true)
       // showImagePickerOptions()
    }
    
//    func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
//        let imagePicker = UIImagePickerController()
//        imagePicker.sourceType = sourceType
//        return imagePicker
//    }
//
//    func showImagePickerOptions() {
//        let alertVC = UIAlertController(title: "Pick a Photo", message: "Choose Picture", preferredStyle: .actionSheet)
//        let libraryAction = UIAlertAction(title: "Library", style: .default) { [weak self] (action) in
//            guard let self = self else {
//                return
//            }
//            let libraryImagePicker = self.imagePicker(sourceType: .photoLibrary)
//            libraryImagePicker.delegate = self
//            self.present(libraryImagePicker, animated: true)
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        alertVC.addAction(libraryAction)
//        alertVC.addAction(cancelAction)
//        self.present(alertVC, animated: true, completion: nil)
//    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        if judul_textfield.text != "" && tahun_textfield.text != "" && penulis_textfield.text != "" {
            let gambar = convertImage(image: imageView.image!)
            if let imageData = imageView.image?.pngData() {
                       coreData.saveImage(data: imageData)
                   }
            let judul = judul_textfield.text
            let tahun = tahun_textfield.text
            let penulis = penulis_textfield.text
          //  let gambar = userimg
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

//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let image = info[.originalImage] as? UIImage {
//                self.imageView.image = image
//                let image1 = resizeImage(image: image, targetSize: CGSize(width: 300, height: 300))
//                userimg = convertImage(image: image1)
//            } else {
//
//            }
//
//            self.dismiss(animated: true, completion: nil)
//
//            let chosenImage = info[.originalImage.rawValue] as? UIImage
//            let imageURL = info[.imageURL] as? URL
//            url = "\(String(describing: imageURL!.path))"
//
//        }
    
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        let chosenImage = info[.originalImage] as? UIImage
        self.imageView.image = chosenImage
        self.dismiss(animated: true, completion: nil)
       
    }
    
    func convertImage(image: UIImage) -> String {
        let imageData:NSData = image.jpegData(compressionQuality: 0.5)! as NSData
        let str = imageData.base64EncodedString(options: .lineLength64Characters)
        return str
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
