//
//  ViewController.swift
//  MiniProject1
//
//  Created by Daniel Andrews on 2/9/17.
//  Copyright © 2017 Shireen And Daniel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let members: [String] = ["Jessica Cherny", "Kevin Jiang", "Jared Gutierrez", "Kristin Ho", "Christine Munar", "Mudit Mittal", "Richard Hu", "Shaan Appel", "Edward Liu", "Wilbur Shi", "Young Lin", "Abhinav Koppu", "Abhishek Mangla", "Akkshay Khoslaa", "Andy Wang", "Aneesh Jindal", "Anisha Salunkhe", "Ashwin Vaidyanathan", "Cody Hsieh", "Justin Kim", "Krishnan Rajiyah", "Lisa Lee", "Peter Schafhalter", "Sahil Lamba", "Sirjan Kafle", "Tarun Khasnavis", "Billy Lu", "Aayush Tyagi", "Ben Goldberg", "Candice Ye", "Eliot Han", "Emaan Hariri", "Jessica Chen", "Katharine Jiang", "Kedar Thakkar", "Leon Kwak", "Mohit Katyal", "Rochelle Shen", "Sayan Paul", "Sharie Wang", "Shreya Reddy", "Shubham Goenka", "Victor Sun", "Vidya Ravikumar"];


    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var statsPicture: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var option1Label: UIButton!
    @IBOutlet weak var option2Label: UIButton!
    @IBOutlet weak var option3Label: UIButton!
    @IBOutlet weak var option4Label: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var name: String = ""
    var streak: Int = 0
    var score: Int = 0
    var timeLeft: Int = 5
    var gameTimer: Timer = Timer()
    var timer: Timer = Timer()
    
    struct defaultsKeys {
        static let longestStreak = "LongestStreak"
        static let points = "Points"
        static let name1 = "Name1"
        static let name2 = "Name2"
        static let name3 = "Name3"
        static let bool1 = "Bool1"
        static let bool2 = "Bool2"
        static let bool3 = "Bool3"
        static let currentStreak = "CurrentStreak"
        static let keepScore = "KeepScore"
    }
    
    @IBAction func option1Button(_ sender: Any) {
        submit(option1Label.currentTitle!, btnNumber: 1, btn: option1Label)
    }
    
    @IBAction func option2Button(_ sender: Any) {
        submit(option2Label.currentTitle!, btnNumber: 2, btn: option2Label)
    }
    
    @IBAction func option3Button(_ sender: Any) {
        submit(option3Label.currentTitle!, btnNumber: 3, btn: option3Label)
    }
    
    @IBAction func option4Button(_ sender: Any) {
        submit(option4Label.currentTitle!, btnNumber: 4, btn: option4Label)
    }
    
    @IBAction func statsButton(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        timer.invalidate()
        gameTimer.invalidate()
        
        defaults.setValue(true, forKey: defaultsKeys.keepScore)
    }
    
    @IBAction func stopButton(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        timer.invalidate()
        gameTimer.invalidate()
        
        defaults.setValue(0, forKey: defaultsKeys.points)
        defaults.setValue(0, forKey: defaultsKeys.currentStreak)
    }
    
    func getName() -> String {
        let size = members.count;
        let randIndex = Int(arc4random_uniform(UInt32(size)))
        return members[randIndex]
    }
    
    func storeValues(streak: Int, score: Int, correct: Bool, name: String) {
        let defaults = UserDefaults.standard
        
        let longest = defaults.integer(forKey: defaultsKeys.longestStreak)
        let name1 = defaults.string(forKey: defaultsKeys.name1)
        let name2 = defaults.string(forKey: defaultsKeys.name2)
        let bool1 = defaults.bool(forKey: defaultsKeys.bool1)
        let bool2 = defaults.bool(forKey: defaultsKeys.bool2)
        
        defaults.setValue(streak, forKey: defaultsKeys.currentStreak)
        if longest < streak {
            defaults.setValue(streak, forKey: defaultsKeys.longestStreak)
        }
        
        defaults.setValue(score, forKey: defaultsKeys.points)
        
        defaults.setValue(name2, forKey: defaultsKeys.name3)
        defaults.setValue(name1, forKey: defaultsKeys.name2)
        defaults.setValue(name, forKey: defaultsKeys.name1)
        
        defaults.setValue(bool2, forKey: defaultsKeys.bool3)
        defaults.setValue(bool1, forKey: defaultsKeys.bool2)
        defaults.setValue(correct, forKey: defaultsKeys.bool1)
        
        defaults.synchronize()
    }
    
    func submit(_ guessedName: String?, btnNumber: Int, btn: UIButton?) {
        gameTimer.invalidate()
        var callWaitASecond = true
        
        if guessedName != nil {
            if guessedName == name {
                //you got it right
                streak += 1
                score += 1
                scoreLabel.text = "Score: \(score)"
                //change button to green
                btn!.backgroundColor = UIColor.green
            } else {
                //You got it wrong
                streak = 0
                
                //change button to red
                btn!.backgroundColor = UIColor.red
            }
        } else {
            streak = 0
            callWaitASecond = false
        }
        
        //Store and replace values
        storeValues(streak: streak, score: score, correct: guessedName == name, name: name)
        
        //move on to next question
        if callWaitASecond {
            waitASecond()
        } else {
            setupGame()
        }
    }
    
    func waitASecond() {
        timer = Timer()
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval:1, target: self, selector: #selector(setupGame), userInfo: nil, repeats: false)
    }
    
    func getNames(used name: String, number n: Int) -> [String] {
        var names: [String] = []
        
        while names.count < n {
            let newName = getName()
            
            if newName != name && !names.contains(newName) {
                names.append(newName)
            }
        }
        
        return names
    }
    
    func setUpOptionLabels(name: String) {
        var options: [String] = [name] + getNames(used: name, number: 3)
    
        option1Label.setTitle(options.remove(at: Int(arc4random_uniform(UInt32(options.count)))), for: UIControlState.normal)
        option2Label.setTitle(options.remove(at: Int(arc4random_uniform(UInt32(options.count)))), for: UIControlState.normal)
        option3Label.setTitle(options.remove(at: Int(arc4random_uniform(UInt32(options.count)))), for: UIControlState.normal)
        option4Label.setTitle(options.remove(at: Int(arc4random_uniform(UInt32(options.count)))), for: UIControlState.normal)
    }
    
    func outOfTime() {
        submit(nil, btnNumber: 0, btn: nil)
    }
    
    func handleTimer() {
        timeLeft -= 1
        timerLabel.text = "\(timeLeft)"
        if timeLeft == 0 {
            outOfTime()
        }
    }
    
    func setupGame() {
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: defaultsKeys.keepScore) {
            score = defaults.integer(forKey: defaultsKeys.points)
            scoreLabel.text = "Score: \(score)"
        }
        
        timeLeft = 5
        timerLabel.text = "\(timeLeft)"
        
        option1Label.backgroundColor = UIColor(red: 0.67, green: 0, blue: 0.3, alpha: 1.0)
        option2Label.backgroundColor = UIColor(red: 0.67, green: 0, blue: 0.3, alpha: 1.0)
        option3Label.backgroundColor = UIColor(red: 0.67, green: 0, blue: 0.3, alpha: 1.0)
        option4Label.backgroundColor = UIColor(red: 0.67, green: 0, blue: 0.3, alpha: 1.0)
        
        name = getName()
        
        var lower = name.lowercased()
        
        lower.remove(at: name.characters.index(of: " ")!)
        personImage.image = UIImage(named: lower)
        
        setUpOptionLabels(name: name)
        
        //Handle time stuff
        gameTimer = Timer.scheduledTimer(timeInterval:1.0, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score)"
        stopButton.addTarget(self, action: #selector(getter: ViewController.stopButton), for: .touchUpInside)
        statsPicture.addTarget(self, action: #selector(ViewController.statsButton), for: .touchUpInside)
        setupGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

