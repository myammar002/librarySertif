//
//  PinjamViewController.swift
//  libraryLoanAmr
//
//  Created by Ammar on 08/05/22.
//

import UIKit

class PinjamViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Borrow"
    }

    @IBAction func btnCreate(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "pinjamID") as! DetailPinjamViewController
        present(vc, animated: true)
    }
}
