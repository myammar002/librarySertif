//
//  RegisterViewController.swift
//  libraryLoanAmr
//
//  Created by Ammar on 08/05/22.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var usertextfield: UITextField!
    @IBOutlet weak var passtextfield: UITextField!
    
    
    @IBAction func registerTap(_ sender: UIButton) {
        if usertextfield.text != "" && passtextfield.text != "" {
            let user = usertextfield.text
            let pass = passtextfield.text
            //  Connection with web server passing the values with POST
             let request = NSMutableURLRequest(url: NSURL(string: "https://yashcollection.000webhostapp.com/library-register.php")! as URL)
             request.httpMethod = "POST"

             // Collect value
            let postString = "user=\(String(describing: user!))&password=\(String(describing: pass!))"
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
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "homeid") as! HomeViewController
            self.navigationController?.pushViewController(vc, animated: true)
            succesAlert()
        } else {
            failAlert()
        }
    }
    
    func succesAlert() {
        let alertController = UIAlertController(title: "Success", message: "User Registered", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func failAlert() {
        let alertController = UIAlertController(title: "Failed", message: "Make sure the fields is not empty", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

}
