//
//  ViewController.swift
//  Swifty_Companion
//
//  Created by Kateryna Zakharchuk on 12/17/17.
//  Copyright © 2017 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
    }

    func assignbackground() {
        let background = UIImage(named: "background")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }
    
    @IBAction func touchSearch(_ sender: UIButton) {
    
    }
    
}

