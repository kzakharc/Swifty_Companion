//
//  customTableViewCell.swift
//  Swifty_Companion
//
//  Created by Kateryna Zakharchuk on 12/29/17.
//  Copyright © 2017 Kateryna Zakharchuk. All rights reserved.
//

import UIKit


class customTableViewCell: UITableViewCell {
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

    @IBOutlet weak var intraProfileImage: UIImageView!
    @IBOutlet weak var diaplayNameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var correctionPointLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var progressViewLabel: UIView!
    
    func setStudentLabels(for studentInfo: StudentStruct) {
        
    }
}
