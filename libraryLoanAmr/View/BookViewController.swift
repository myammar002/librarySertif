//
//  BookViewController.swift
//  libraryLoanAmr
//
//  Created by Ammar on 08/05/22.
//

import UIKit
import CoreData

class BookViewController: UIViewController {
    var fetchData = FetchData()
    var coreData = DatabaseHelper()
    @IBOutlet weak var bookTableView: UITableView!
    var dataModel = [ResponseBuku]()
    {
        didSet
        {
            DispatchQueue.main.async {
                self.bookTableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // coreData.deleteAllData(entity: "Image")
        title = "Books"
        bookTableView.delegate = self
        bookTableView.dataSource = self
        bookTableView.register(UINib(nibName: "BookTableViewCell", bundle: nil), forCellReuseIdentifier: "bookCell")
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.fetchData.fetchData { dataArray in
            self.dataModel = dataArray
        }
    }

    @IBAction func addBook(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "addBook") as! AddBookViewController
        vc.refreshDelegate = self
        present(vc, animated: true)
    }

}

protocol RefreshDelegate:AnyObject {
    func goLoad()
}

extension BookViewController: RefreshDelegate {
    func goLoad() {
        self.fetchData.fetchData { dataArray in
            self.dataModel = dataArray
        }
        self.bookTableView.reloadData()
    }
}

extension BookViewController: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookTableViewCell
        let data = dataModel[indexPath.row]
        let dataImage = coreData.fetchImage()
        cell.lbl_judul.text = "Nama Buku : \(data.nama_buku)"
        cell.lbl_tahun.text = "Tahun Rilis : \(data.tahun_rilis)"
        cell.lbl_penulis.text = "Penulis : \(data.penulis)"
//        let url = URL(string: data.gambar_buku)!
//        if let data = try? Data(contentsOf: url) {
//            let image: UIImage = UIImage(data: data)!
//            cell.imageBook.image = image
//        }
        cell.imageBook.image = UIImage(data: dataImage[indexPath.row].img!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let data = self.dataModel[indexPath.row]
            let namaBuku = data.nama_buku
            //  Connection with web server passing the values with POST
            let request = NSMutableURLRequest(url: NSURL(string: "https://yashcollection.000webhostapp.com/library-delete-buku.php")! as URL)
            request.httpMethod = "POST"

            // Collect value
            let postString = "produk=\(namaBuku)"
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
            self.dataModel.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
    }
}

extension BookViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dBuku = self.dataModel[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "detailBook") as! DetailBookViewController
        vc.title = dBuku.nama_buku
        vc.dBook = dBuku
        vc.idBuku = dBuku.id
        navigationController?.pushViewController(vc, animated: true)
    }
}

