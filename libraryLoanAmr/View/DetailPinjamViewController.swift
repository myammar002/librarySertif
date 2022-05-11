//
//  DetailPinjamViewController.swift
//  libraryLoanAmr
//
//  Created by Ammar on 08/05/22.
//

import UIKit

class DetailPinjamViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var nama_text: UITextField!
    @IBOutlet weak var datePinjam: UIDatePicker!
    @IBOutlet weak var dateKembali: UILabel!
    @IBOutlet weak var tanggalPinjam: UILabel!
    @IBOutlet weak var btn_book: UIButton!
    
    var strDate = ""
    var strReturn = ""
    
    weak var bookDelegate : BookDelegate?
    
    var selectedBook : String = ""
    var pickerView : UIPickerView? = nil
    var indexPickerView = 0
    
    let screenWidthPick = UIScreen.main.bounds.width - 10
    let screenHeightPick = UIScreen.main.bounds.height / 4
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var fetchData = FetchData()
    var dataModel = [ResponseBuku]()
    {
        didSet
        {
            DispatchQueue.main.async {
                //print(self.dataModel[0].nama_buku)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData.fetchData { dataArray in
            self.dataModel = dataArray
        }
    }
    
    @IBAction func chooseBook(_ sender: UIButton) {
        let vc = DetailPinjamViewController()
        vc.preferredContentSize = CGSize(width: screenWidthPick, height: screenHeightPick)
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidthPick, height: screenHeightPick))
        pickerView?.dataSource = self
        pickerView?.delegate = self
        vc.view.addSubview(pickerView!)
        pickerView?.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView?.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        if selectedBook == "Male"{
            indexPickerView = 0
        }else{
            indexPickerView = 1
        }
        pickerView?.selectRow(indexPickerView, inComponent: 0, animated: true)
        
        let alert = UIAlertController(title: "Choose Book ", message: "", preferredStyle: .actionSheet)
        alert.popoverPresentationController?.sourceView = btn_book
        alert.popoverPresentationController?.sourceRect = btn_book.bounds
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (UIAlertAction)
            in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        dataModel.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataModel[row].nama_buku
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedBook = dataModel[row].nama_buku
        btn_book.setTitle(selectedBook, for: .normal)
    }
    
    @IBAction func btnsave(_ sender: UIButton) {
        if nama_text.text != "" && tanggalPinjam.text != "Label" {
            let nama_peminjam = nama_text.text
            //  Connection with web server passing the values with POST
             let request = NSMutableURLRequest(url: NSURL(string: "https://yashcollection.000webhostapp.com/library-add-invoice.php")! as URL)
             request.httpMethod = "POST"

             // Collect value
            let postString = "nama=\(strDate)&tahun=\(nama_peminjam!)&penulis=\(selectedBook)&gambar=\(strReturn)"
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
            updateBookServer(nama: selectedBook)
            let alertController = UIAlertController(title: "Succesfully", message: "Invoice Ditambahkan", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {action in
                self.dismiss(animated: true, completion: { [self] in
                    bookDelegate?.goLoad()
                } )
    }))
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Unsuccesfully", message: "Pastikan semua data sudah diisi", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    func updateBookServer(nama : String) {
        //  Connection with web server passing the values with POST
         let request = NSMutableURLRequest(url: NSURL(string: "https://yashcollection.000webhostapp.com/library-update-invoiceBook.php")! as URL)
         request.httpMethod = "POST"
        
         // Collect value
        let postString = "nama=\(nama)"
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
        
    }
    
    @IBAction func btncancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        var dateComponent = DateComponents()
        dateComponent.day = 7
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short

        strDate = dateFormatter.string(from: datePinjam.date)
        let returnDate = Calendar.current.date(byAdding: dateComponent, to: datePinjam.date)
        strReturn = dateFormatter.string(from: returnDate!)
        
        tanggalPinjam.text = strDate
        dateKembali.text = strReturn
    }
    
}
