//
//  ViewController.swift
//  Milestone-Projects 7-9
//
//  Created by Tareq Alhammoodi on 25.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var currentWord = ""
    var wordsList = [String]()
    var lettersUsed = [String]()
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var allLetters = [String](arrayLiteral: "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
                              "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", " ", " ", " ", " ")
    
    var chances = 7 {
        didSet {
            chancesLabel.text = "Chances: \(chances)"
        }
    }
    
    var level = 1 {
        didSet {
            levelLabel.text = "Level: \(level)"
        }
    }
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    let wordLabel: UITextField = {
        let wordLabel = UITextField()
        wordLabel.textColor = .gray
        wordLabel.textAlignment = .center
        wordLabel.backgroundColor = .systemGray6
        wordLabel.font = UIFont(name: "Avenir-Medium", size: 25.0)
        wordLabel.isUserInteractionEnabled = false
        return wordLabel
    }()
    
    let chancesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font =  UIFont(name: "Avenir-Medium", size: 20.0)
        return label
    }()
    
    let levelLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.font =  UIFont(name: "Avenir-Medium", size: 20.0)
        return label
    }()
    
    let buttonsView: UIView = {
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        return buttonsView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Hangman Game"
        chancesLabel.text = "Chances: \(chances)"
        levelLabel.text = "Level: \(level)"
        view.addSubview(scrollView)
        scrollView.addSubview(wordLabel)
        scrollView.addSubview(buttonsView)
        scrollView.addSubview(chancesLabel)
        scrollView.addSubview(levelLabel)
        // set letter buttons
        let width = 40
        let height = 40
        for row in 0..<5 {
            for column in 0..<6 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 20.0)
                for i in 0..<letterButtons.count {
                    letterButtons[i].setTitle(allLetters[i], for: .normal)
                }
                letterButton.tintColor = .black
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
        // read words form words.text file
        if let wordsURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let words = try? String(contentsOf: wordsURL) {
                wordsList = words.components(separatedBy: "\n")
            }
        }
        // load new word
        getWord()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        chancesLabel.frame = CGRect(x: 20,
                                  y: 10,
                                  width: 150,
                                  height: 30)
        levelLabel.frame = CGRect(x: scrollView.width-170,
                                  y: 10,
                                  width: 150,
                                  height: 30)
        wordLabel.frame = CGRect(x: (scrollView.width-(scrollView.width-100))/2,
                                 y: chancesLabel.top+70,
                                 width: scrollView.width-100,
                                 height: 75)
        buttonsView.frame = CGRect(x: (scrollView.width-(250))/2,
                                   y: wordLabel.top+120,
                                   width: 250,
                                   height: 250)
        
    }
    
    func getWord() {
        currentWord = wordsList.randomElement()!
        if currentWord == "" || currentWord == " " {
            currentWord = "bread"
        }
        wordLabel.text = String(repeating: "?", count: currentWord.count)
    }
    
    func showErrorMessage(letter: String) {
        let alert = UIAlertController(title: nil, message: "The letter \(letter) that you pressed is not in the word", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    func levelUp(action: UIAlertAction) {
        level += 1
        lettersUsed.removeAll(keepingCapacity: true)
        getWord()
        for button in letterButtons {
            button.isHidden = false
        }
    }
    
    func startAgain(action: UIAlertAction) {
        level = 1
        chances = 7
        getWord()
        lettersUsed.removeAll(keepingCapacity: true)
        for button in letterButtons {
            button.isHidden = false
        }
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let letterTapped = sender.titleLabel?.text else { return }
        lettersUsed.append(letterTapped)
        if currentWord.uppercased().contains(letterTapped) {
            var tempWord = ""
            for letter in currentWord.uppercased() {
                if lettersUsed.contains(String(letter)) {
                    tempWord += String(letter)
                } else {
                    tempWord += "?"
                }
            }
            wordLabel.text = tempWord
        } else {
            chances -= chances != 0 ? 1 : 0
            if chances == 0 {
                let alert = UIAlertController(title: "Game over!", message: "Wanna play again?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: startAgain))
                present(alert, animated: true)
            } else {
                showErrorMessage(letter: "\(letterTapped)")
            }
        }
        if wordLabel.text == currentWord.uppercased() {
            chances += 1
            let alert = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
            present(alert, animated: true)
        }
        activatedButtons.append(sender)
        sender.isHidden = true
    }

}

