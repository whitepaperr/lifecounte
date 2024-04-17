//
//  ViewController.swift
//  Life Counter
//
//  Created by 이하은 on 4/16/24.
//

import UIKit

class ViewController: UIViewController {
    
    var player1LifeLabel = UILabel()
    var player2LifeLabel = UILabel()
    var gameOverLabel = UILabel()
    var player1Life = 20
    var player2Life = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        updateLifeLabels()
    }

    func setupUI() {
        if player1LifeLabel.superview == nil {
            addLabel(player1LifeLabel, at: 0.33, text: "Player 1 Life: \(player1Life)")
            addLabel(player2LifeLabel, at: 0.6, text: "Player 2 Life: \(player2Life)")
            addGameOverLabel()

            setupButtons(below: player1LifeLabel, offset: 30, selectors: [
                #selector(player1Increment), #selector(player1Decrement),
                #selector(player1IncrementFive), #selector(player1DecrementFive)
            ])
                
            setupButtons(below: player2LifeLabel, offset: 30, selectors: [
                #selector(player2Increment), #selector(player2Decrement),
                #selector(player2IncrementFive), #selector(player2DecrementFive)
            ])
        }
    }
    
    func addLabel(_ label: UILabel, at relativePosition: CGFloat, text: String) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.text = text
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: (view.frame.height * relativePosition) - (view.frame.height / 2)),
            label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            label.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    
    func addGameOverLabel() {
        gameOverLabel.translatesAutoresizingMaskIntoConstraints = false
        gameOverLabel.textAlignment = .center
        gameOverLabel.font = UIFont.systemFont(ofSize: 15)
        gameOverLabel.textColor = .red
        view.addSubview(gameOverLabel)
        
        NSLayoutConstraint.activate([
            gameOverLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameOverLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            gameOverLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            gameOverLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func setupButtons(below label: UILabel, offset: CGFloat, selectors: [Selector]) {
        let buttonTitles = ["+", "-", "+5", "-5"]
        let buttonWidth: CGFloat = 44
        let buttonSpacing: CGFloat = 10

        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = buttonSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
            
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: offset),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
            
        for (index, title) in buttonTitles.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
            button.heightAnchor.constraint(equalToConstant: buttonWidth).isActive = true

            stackView.addArrangedSubview(button)
            button.addTarget(self, action: selectors[index], for: .touchUpInside)
        }
    }

    func updateLifeLabels() {
        player1LifeLabel.text = "Player 1 Life: \(player1Life)"
        player2LifeLabel.text = "Player 2 Life: \(player2Life)"
        checkForGameOver()
    }
    
    func checkForGameOver() {
        if player1Life <= 0 {
            gameOverLabel.text = "Player 1 LOSES!"
        } else if player2Life <= 0 {
            gameOverLabel.text = "Player 2 LOSES!"
        } else {
            gameOverLabel.text = ""
        }
    }

    @objc func player1Increment() { changeLife(player: 1, amount: 1) }
    @objc func player1Decrement() { changeLife(player: 1, amount: -1) }
    @objc func player1IncrementFive() { changeLife(player: 1, amount: 5) }
    @objc func player1DecrementFive() { changeLife(player: 1, amount: -5) }
    
    @objc func player2Increment() { changeLife(player: 2, amount: 1) }
    @objc func player2Decrement() { changeLife(player: 2, amount: -1) }
    @objc func player2IncrementFive() { changeLife(player: 2, amount: 5) }
    @objc func player2DecrementFive() { changeLife(player: 2, amount: -5) }

    func changeLife(player: Int, amount: Int) {
        if player == 1 {
            player1Life += amount
        } else if player == 2 {
            player2Life += amount
        }
        updateLifeLabels()
    }
}
