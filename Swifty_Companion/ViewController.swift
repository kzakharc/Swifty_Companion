//
//  ViewController.swift
//  Swifty_Companion
//
//  Created by Kateryna Zakharchuk on 12/17/17.
//  Copyright © 2017 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    var token = String()
    var studentName = String()
    var student = StudentStruct()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.isHidden = true
        
        usernameField.alpha = 0.8
        usernameField.layer.cornerRadius = 5
        usernameField.layer.borderWidth = 1.5
        usernameField.layer.borderColor = UIColor.white.cgColor
        
        searchButton.backgroundColor = .clear
        searchButton.layer.cornerRadius = 5
        searchButton.layer.borderWidth = 1.5
        searchButton.layer.borderColor = UIColor.white.cgColor
        
    }
    
    func emtyField() {
        errorLabel.alpha = 0.8
        errorLabel.backgroundColor = UIColor(red:0.92, green:0.89, blue:0.61, alpha:1.0)
        errorLabel.textColor = UIColor(red:1.00, green:0.40, blue:0.40, alpha:1.0)
        errorLabel.text = "User name field is emty!"
        errorLabel.isHidden = false
    }
    
    func checkName() {
        
        DispatchQueue.main.async {
            self.errorLabel.alpha = 0.7
            self.errorLabel.backgroundColor = UIColor(red:1.00, green:0.40, blue:0.40, alpha:1.0)
            self.errorLabel.textColor = UIColor(red:0.92, green:0.89, blue:0.61, alpha:1.0)
            self.errorLabel.text = "Wrong user name!"
            self.errorLabel.isHidden = false
        }
    }
    
    @IBAction func touchSearch(_ sender: UIButton) {
        errorLabel.isHidden = true
        if let name = usernameField.text {
            studentName = name.split(separator: " ").joined()
            if studentName == "" {
                emtyField()
            } else {
                student = StudentStruct()
                student.login = studentName
            }
        }
        
        if studentName != "" {
            let UID = "0a9eca6eb26d9156b2607741999cddbd50f6ee9dc6166ca66c46aabf3fd0a7f5"
            let SECRET = "dc4c2087acf4020acd0b93fad8d6999d5230b68653390bf907c0e04b1763cdf4"
            let BEARER = ((UID + ":" + SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
            
            let url = NSURL(string: "https://api.intra.42.fr/oauth/token")
            var request = URLRequest(url: url! as URL)
            request.httpMethod = "POST"
            request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
            request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = "grant_type=client_credentials&client_id=0a9eca6eb26d9156b2607741999cddbd50f6ee9dc6166ca66c46aabf3fd0a7f5&client_secret=dc4c2087acf4020acd0b93fad8d6999d5230b68653390bf907c0e04b1763cdf4".data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                print(request)
                if let err = error {
                    print(err)
                }
                else if let d = data {
                    do {
                        if let dic = try JSONSerialization.jsonObject(with: d, options: []) as? NSDictionary {
                            if let t = dic["access_token"] as? String {
                                self.token = t
                                self.signIn(token: self.token)
                            }
                        }
                    }
                    catch (let err) {
                        print(err)
                    }
                }
            }
            task.resume()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dectinationView: MyTableViewController = segue.destination as! MyTableViewController
        dectinationView.studentInfo = self.student
    }
    
    func signIn(token: String) {
        print(token)
        let req = "https://api.intra.42.fr/v2/users/" + studentName.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)! + "?access_token=" + self.token
        let url = URL(string: req)
        let request = URLRequest(url: url! as URL)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    if let dic = try JSONSerialization.jsonObject(with: d, options: []) as? NSDictionary {
                        if let name = dic["displayname"] as? String {
                            self.student.displayname = name
                        }
                        if let email = dic["email"] as? String {
                            self.student.email = email
                        }
                        if let phone = dic["phone"] as? String {
                            self.student.phone = phone
                        }
                        if let correction_point = dic["correction_point"] as? Int {
                            self.student.correction_point = correction_point
                        }
                        if let location = dic["location"] as? String {
                            self.student.location = location
                        }
                        if let wallet = dic["wallet"] as? Int {
                            self.student.wallet = wallet
                        }
                        if let pool_year = dic["pool_year"] as? Int {
                            self.student.pool_year = pool_year
                        }
                        if let dictionary = dic["cursus_users"] as? [NSDictionary] {
                            for cursus in dictionary {
                                if let a = cursus.value(forKey: "cursus_id") as? Int {
                                    if a == 1 {
                                        if let g = cursus.value(forKey: "grade") as? String {
                                            self.student.grade = g
                                        }
                                        if let l = cursus.value(forKey: "level") as? Float {
                                            self.student.level = l
                                        }
                                        if let skillDictionary = cursus.value(forKey: "skills") as? [NSDictionary] {
                                            for skill in skillDictionary {
                                                self.student.skills.append(SkillsStruct(name: skill.value(forKey: "name") as? String, level: skill.value(forKey: "level") as? Float))
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        if let projects = dic["projects_users"] as? [NSDictionary] {
                            for project in projects {
                                if let a = project.value(forKey: "cursus_ids") as? [Int] {
                                    if a[0] == 1 {
                                       if let mark = project.value(forKey: "final_mark") as? Int,
                                        let valid = project.value(forKey: "validated?") as? Bool,
                                        let pro = project.value(forKey: "project") as? [String: Any?] {
                                            self.student.projects.append(MarksStruct(finalMark: mark, name: pro["slug"] as? String, validated: valid))
                                        }
                                    }
                                }
                            }
                        }
                        if dic.count == 0 {
                            self.checkName()
                        } else {
                            //setStudentLabels(self.student)
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "firstSegue", sender: self)
                                self.usernameField.text = ""
                            }
                        }
                    }
                }
                catch (let err) {
                    print(err)
                }
                
            }
        }
        task.resume()
    }
    
}



