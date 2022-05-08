//
//  LoginViewController.swift
//  libraryLoanAmr
//
//  Created by Ammar on 08/05/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userlogin: UITextField!
    @IBOutlet weak var passogin: UITextField!
    
    var anchor = 0
   
    @IBAction func loginTap(_ sender: UIButton) {
        if userlogin.text != "" && passogin.text != "" {
            let user = userlogin.text
            let pass = passogin.text
            //  Connection with web server passing the values with POST
             let request = NSMutableURLRequest(url: NSURL(string: "https://yashcollection.000webhostapp.com/library-login.php")! as URL)
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
                 print("responseString= \(responseString!)")
                 let hash = responseString!.hash
                 if hash != 30954373840{
                     self.anchor = 1
                     print("test : \(self.anchor)")
                 }
             }
             task.resume()
            print(anchor)
            if anchor == 1 {
                failAlert()
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "homeid") as! HomeViewController
                self.navigationController?.pushViewController(vc, animated: true)
                succesAlert()
            }
           
        } else {
            failAlert()
        }
    }
    
    
    
    func succesAlert() {
        let alertController = UIAlertController(title: "Success", message: "User Login", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func failAlert() {
        let alertController = UIAlertController(title: "Failed", message: "Make sure the data is correct and fields is not empty", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
