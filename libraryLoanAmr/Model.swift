//
//  Model.swift
//  libraryLoanAmr
//
//  Created by Ammar on 08/05/22.
//

import UIKit


struct ResponseBuku : Codable {
    var id: String
    var nama_buku : String
    var tahun_rilis : String
    var penulis: String
    var gambar_buku: String
}

struct ResponseInvoice: Codable {
    var id: String
    var nama_buku : String
    var nama_peminjam : String
    var tanggal_kembali : String
    var tanggal_pinjam: String
}
