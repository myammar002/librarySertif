//
//  HomeViewController.swift
//  libraryLoanAmr
//
//  Created by Ammar on 08/05/22.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLogOut(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
   

}
