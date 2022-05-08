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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnsave(_ sender: UIButton) {
    }
    
    @IBAction func btncancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
}
