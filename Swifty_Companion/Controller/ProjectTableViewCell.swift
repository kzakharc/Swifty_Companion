
//
//  projectTableViewCell.swift
//  Swifty_Companion
//
//  Created by Kateryna Zakharchuk on 1/12/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var projectNameLabel: UILabel!
    
    func setStudentProject(project: MarksStruct) {
        if let mark = project.finalMark, let name = project.name, let validated = project.validated {
            if validated == true {
                projectNameLabel.text = "☑️  Mark: " + String(mark) + " Name: " + name
                projectNameLabel.textColor = UIColor(red:0.62, green:0.42, blue:0.75, alpha:1.0)
            } else {
                projectNameLabel.text = "❌  Mark: " + String(mark) + " Name: " + name
                projectNameLabel.textColor = UIColor(red:0.64, green:0.64, blue:0.64, alpha:1.0)
            }
        }
    }
}
