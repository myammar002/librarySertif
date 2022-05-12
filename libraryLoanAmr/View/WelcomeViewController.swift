//
//  ViewController.swift
//  libraryLoanAmr
//
//  Created by Ammar on 07/05/22.
//

import UIKit
import GhostTypewriter

class ViewController: UIViewController {
    @IBOutlet weak var tes: TypewriterLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tes.startTypewritingAnimation()
    }


}

