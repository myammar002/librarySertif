//
//  BorrowCell.swift
//  libraryLoanAmr
//
//  Created by Ammar on 08/05/22.
//

import UIKit

class BorrowCell: UITableViewCell {

    @IBOutlet weak var invoice: UILabel!
    @IBOutlet weak var nama: UILabel!
    @IBOutlet weak var nama_peminjam: UILabel!
    @IBOutlet weak var admin: UILabel!
    @IBOutlet weak var tanggal_pinjam: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
