//
//  customTableViewCell.swift
//  Swifty_Companion
//
//  Created by Kateryna Zakharchuk on 12/29/17.
//  Copyright © 2017 Kateryna Zakharchuk. All rights reserved.
//

import UIKit


class customTableViewCell: UITableViewCell {
    
    @IBOutlet weak var intraProfileImage: UIImageView! // not set
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var correctionPointLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var progressViewLabel: UIView! // not set
    
    func setStudentLabels(for studentInfo: StudentStruct) {
        displayNameLabel.text = studentInfo.displayname
        loginLabel.text = studentInfo.login
        phoneNumberLabel.text = studentInfo.phone
        locationLabel.text = studentInfo.location
        walletLabel.text = String(studentInfo.wallet)
        correctionPointLabel.text = String(studentInfo.correction_point)
        yearLabel.text = String(studentInfo.pool_year)
        levelLabel.text = String(studentInfo.level)
    }
}
