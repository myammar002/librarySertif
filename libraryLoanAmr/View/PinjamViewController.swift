//
//  PinjamViewController.swift
//  libraryLoanAmr
//
//  Created by Ammar on 08/05/22.
//

import UIKit

class PinjamViewController: UIViewController {
    @IBOutlet weak var dataInvoice: UITableView!
    var fetchData = FetchData()
    var dataModel = [ResponseInvoice]()
    {
        didSet
        {
            DispatchQueue.main.async {
                self.dataInvoice.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.fetchData.fetchDataInvo { dataArray in
            self.dataModel = dataArray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Borrow"
        dataInvoice.delegate = self
        dataInvoice.dataSource = self
        dataInvoice.register(UINib(nibName: "BorrowCell", bundle: nil), forCellReuseIdentifier: "borrowCell")
    }

    @IBAction func btnCreate(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "pinjamID") as! DetailPinjamViewController
        vc.bookDelegate = self
        present(vc, animated: true)
    }
    
    
}

protocol BookDelegate:AnyObject {
    func goLoad()
}

extension PinjamViewController: BookDelegate {
    func goLoad() {
        self.fetchData.fetchDataInvo { dataArray in
            self.dataModel = dataArray
        }
        self.dataInvoice.reloadData()
    }
}

extension PinjamViewController: UITableViewDelegate {
    
}

extension PinjamViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "borrowCell", for: indexPath) as! BorrowCell
        let data = dataModel[indexPath.row]
        cell.nama_peminjam.text = data.nama_peminjam
        cell.admin.text = data.tanggal_kembali
        cell.invoice.text = data.id
        cell.nama.text = data.nama_buku
        cell.tanggal_pinjam.text = data.tanggal_pinjam
        return cell
    }
}
