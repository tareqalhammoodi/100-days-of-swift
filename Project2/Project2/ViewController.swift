//
//  ViewController.swift
//  Project2
//
//  Created by Tareq Alhammoodi on 5.07.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var scoreLabel = UILabel()
    var questionLabel = UILabel()
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var currentQuestion = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion(action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: scoreLabel)
        scoreLabel.text = "Score: \(score)"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: questionLabel)
        questionLabel.text = "Question: \(currentQuestion)"

    }
    
    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        title = countries[correctAnswer].uppercased()
    }
    
    func restartGame(action: UIAlertAction!) {
        currentQuestion = 1
        score = 0
        askQuestion(action: nil)
        scoreLabel.text = "Score: \(score)"
        questionLabel.text = "Question: \(currentQuestion)"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            currentQuestion += 1
            scoreLabel.text = "Score: \(score)"
            questionLabel.text = "Question: \(currentQuestion)"
        } else {
            title = "Wrong, this is \(countries[sender.tag].uppercased())'s flag!"
            score -= 1
            currentQuestion += 1
            scoreLabel.text = "Score: \(score)"
            questionLabel.text = "Question: \(currentQuestion)"
        }
        
        if currentQuestion > 0 && currentQuestion < 11 {
            let alert = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: title, message: "Game is over, total score: \(score)/10", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: restartGame))
            present(alert, animated: true)
        }
        
    }
    
}

