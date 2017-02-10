//
//  StatsViewController.swift
//  MiniProject1
//
//  Created by Shireen Warrier on 2/9/17.
//  Copyright © 2017 Shireen And Daniel. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {

    @IBOutlet weak var longestStreakLabel: UILabel!
    @IBOutlet weak var nameLabel1: UILabel!
    @IBOutlet weak var nameLabel2: UILabel!
    @IBOutlet weak var nameLabel3: UILabel!
    @IBOutlet weak var boolImage1: UIImageView!
    @IBOutlet weak var boolImage2: UIImageView!
    @IBOutlet weak var boolImage3: UIImageView!
    @IBOutlet weak var longestStreakNum: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    func setUpImages() {
        let defaults = UserDefaults.standard
        
        if defaults.bool(forKey: ViewController.defaultsKeys.bool1) {
            boolImage1.image = UIImage(named: "thumbup")
        } else {
            boolImage1.image = UIImage(named: "thumbdown")
        }
        
        if defaults.bool(forKey: ViewController.defaultsKeys.bool2) {
            boolImage2.image = UIImage(named: "thumbup")
        } else {
            boolImage2.image = UIImage(named: "thumbdown")
        }
        
        if defaults.bool(forKey: ViewController.defaultsKeys.bool3) {
            boolImage3.image = UIImage(named: "thumbup")
        } else {
            boolImage3.image = UIImage(named: "thumbdown")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        nameLabel1.text = defaults.string(forKey: ViewController.defaultsKeys.name1)
        nameLabel2.text = defaults.string(forKey: ViewController.defaultsKeys.name2)
        nameLabel3.text = defaults.string(forKey: ViewController.defaultsKeys.name3)
        longestStreakNum.text = String(defaults.integer(forKey: ViewController.defaultsKeys.longestStreak))
        
        setUpImages()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
