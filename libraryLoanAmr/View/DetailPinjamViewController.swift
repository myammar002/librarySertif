//
//  DetailPinjamViewController.swift
//  libraryLoanAmr
//
//  Created by Ammar on 08/05/22.
//

import UIKit

class DetailPinjamViewController: UIViewController {

    @IBOutlet weak var nama_text: UITextField!
    @IBOutlet weak var buku_text: UITextField!
    @IBOutlet weak var datePinjam: UIDatePicker!
    @IBOutlet weak var dateKembali: UILabel!
    @IBOutlet weak var tanggalPinjam: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnsave(_ sender: UIButton) {
        
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

        let strDate = dateFormatter.string(from: datePinjam.date)
        let returnDate = Calendar.current.date(byAdding: dateComponent, to: datePinjam.date)
        let strReturn = dateFormatter.string(from: returnDate!)
        
        tanggalPinjam.text = strDate
        dateKembali.text = strReturn
    }
    
}
