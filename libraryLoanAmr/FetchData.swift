//
//  FetchData.swift
//  libraryLoanAmr
//
//  Created by Ammar on 08/05/22.
//

import Foundation

struct FetchData {
    func fetchData(completionHandler: @escaping ([ResponseBuku]) -> Void) {
        var dataBuku = [ResponseBuku]()
       
        //Connection with web server passing the values with GET
        let request = NSMutableURLRequest(url: NSURL(string: "https://yashcollection.000webhostapp.com/library-get-data-buku.php")! as URL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in

            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            
            guard let data = data else {
                print("invalid response")
                return
            }
            // convert JSON response into class model as an array
            let decoder = JSONDecoder()
            do {
               dataBuku = try! decoder.decode([ResponseBuku].self, from: data)
                completionHandler(dataBuku)
            } catch {
                print(error)
            }
        }
        task.resume()

    }
    func fetchDataInvo(completionHandler: @escaping ([ResponseInvoice]) -> Void) {
        var dataInvo = [ResponseInvoice]()
       
        //Connection with web server passing the values with GET
        let request = NSMutableURLRequest(url: NSURL(string: "https://yashcollection.000webhostapp.com/library-get-data-invoice.php")! as URL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in

            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            
            guard let data = data else {
                print("invalid response")
                return
            }
            // convert JSON response into class model as an array
            let decoder = JSONDecoder()
            do {
               dataInvo = try! decoder.decode([ResponseInvoice].self, from: data)
                completionHandler(dataInvo)
            } catch {
                print(error)
            }
        }
        task.resume()

    }
}
