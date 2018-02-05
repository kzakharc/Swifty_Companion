//
//  MyTableViewController.swift
//  Swifty_Companion
//
//  Created by Kateryna Zakharchuk on 1/3/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {
    
    var studentInfo: StudentStruct?
    let sections: [String] = ["Profile", "Skills", "Projects"]
    let sectionsImages: [UIImage] = [#imageLiteral(resourceName: "profile"), #imageLiteral(resourceName: "skills"), #imageLiteral(resourceName: "project")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            if let skillsCount = studentInfo?.skills.count {
                return skillsCount
            }
        }
        else if section == 2 {
            if let projectsCount = studentInfo?.projects.count {
                return projectsCount
            }
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.73, green:0.74, blue:0.88, alpha:1.0)
        
        let image = UIImageView(image: sectionsImages[section])
        image.frame = CGRect(x: 5, y: 5, width: 35, height: 35)
        view.addSubview(image)
        
        let label = UILabel()
        label.text = sections[section]
        label.frame = CGRect(x: 45, y: 5, width: 100, height: 35)
        view.addSubview(label)
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? customTableViewCell {
                if let studInfo = studentInfo {
                    cell.setStudentLabels(for: studInfo)
                }
                return cell
            }
        }
        else if indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "skillsCell", for: indexPath) as? skillsTableViewCell {
                if let someSkill = studentInfo?.skills[indexPath.row] {
                    cell.setStudentSkills(skill: someSkill)
                }
                return cell
            }
        }
        else if indexPath.section == 2 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as? projectTableViewCell {
                if let someProject = studentInfo?.projects[indexPath.row] {
                    cell.setStudentProject(project: someProject)
                    if let valid = someProject.validated {
                        if valid == true {
                            cell.contentView.backgroundColor = UIColor(red:0.92, green:0.88, blue:0.95, alpha:1.0)
                        } else {
                            cell.contentView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
                        }
                    }
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
