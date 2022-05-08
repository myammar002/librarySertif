//
//  BookViewController.swift
//  libraryLoanAmr
//
//  Created by Ammar on 08/05/22.
//

import UIKit

class BookViewController: UIViewController {
    var fetchData = FetchData()
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
    }
    

}

extension BookViewController: UITableViewDelegate, UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookTableViewCell
        let data = dataModel[indexPath.row]
        cell.lbl_judul.text = "Nama Buku : \(data.nama_buku)"
        cell.lbl_tahun.text = "Tahun Rilis : \(data.tahun_rilis)"
        cell.lbl_penulis.text = "Penulis : \(data.penulis)"
        //cell.imageBook?.image = data.gambar
        return cell
    }


}
