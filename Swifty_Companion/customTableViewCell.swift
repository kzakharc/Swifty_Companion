//
//  customTableViewCell.swift
//  Swifty_Companion
//
//  Created by Kateryna Zakharchuk on 12/29/17.
//  Copyright © 2017 Kateryna Zakharchuk. All rights reserved.
//

import UIKit


class customTableViewCell: UITableViewCell {
    
    @IBOutlet weak var intraProfileImage: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var correctionPointLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    func setStudentLabels(for studentInfo: StudentStruct) {
        
        displayNameLabel.text = studentInfo.displayname
        loginLabel.text = studentInfo.login
        phoneNumberLabel.text = studentInfo.phone
        locationLabel.text = studentInfo.location
        walletLabel.text = "Wallet : " + String(studentInfo.wallet)
        correctionPointLabel.text = "Correction : " + String(studentInfo.correction_point)
        yearLabel.text = "Year : " + String(studentInfo.pool_year)
        levelLabel.text = String(studentInfo.level)
        gradeLabel.text = "Grade : " + studentInfo.grade
        emailLabel.text = studentInfo.email
        
        if let imageAdrs = studentInfo.imageUrl {
            let URL_IMAGE = URL(string: imageAdrs)
            let session = URLSession(configuration: .default)
            let getImageFromUrl = session.dataTask(with: URL_IMAGE!) { (data, response, error) in
                if let e = error {
                    print("Error Occurred: \(e)")
                } else {
                    if (response as? HTTPURLResponse) != nil {
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            DispatchQueue.main.async {
                                self.intraProfileImage.image = image
                                self.intraProfileImage.layer.masksToBounds = false
                                self.intraProfileImage.layer.cornerRadius = self.intraProfileImage.frame.size.width / 2
                                self.intraProfileImage.clipsToBounds = true
                            }
                        } else {
                            print("Image file is currupted")
                        }
                    } else {
                        print("No response from server")
                    }
                }
            }
            getImageFromUrl.resume()
        }
    }
}


