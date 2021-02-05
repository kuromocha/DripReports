//
//  ReportTableViewCell.swift
//  DripReports
//
//  Created by 嘉山正太郎 on 2020/10/22.
//

import UIKit

class ReportTableViewCell: UITableViewCell {


    @IBOutlet weak var roasterLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var beansProcessLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var beansAmountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
