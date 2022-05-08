//
//  BookTableViewCell.swift
//  libraryLoanAmr
//
//  Created by Ammar on 08/05/22.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_penulis: UILabel!
    @IBOutlet weak var lbl_tahun: UILabel!
    @IBOutlet weak var lbl_judul: UILabel!
    @IBOutlet weak var imageBook: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
