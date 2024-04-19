//
//  ViewController.swift
//  Life Counter
//
//  Created by 이하은 on 4/16/24.
//

import UIKit

class ViewController: UIViewController {
    
    var scrollView = UIScrollView()
    var contentView = UIView()
    var gameOverLabel = UILabel()
    var addPlayerButton = UIButton()
    var historyButton = UIButton()
    var players: [PlayerView] = []
    var gameStarted = false
    var history: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        addTapGesture()
    }

    func setupUI() {
        setupScrollView()
        setupButtons()
        setupGameOverLabel()
        setupConstraints()
        for index in 1...4 {
            addPlayer(index: index)
        }
    }

    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
    }

    func setupButtons() {
        addPlayerButton.setTitle("Add Player", for: .normal)
        addPlayerButton.backgroundColor = .systemBlue
        addPlayerButton.addTarget(self, action: #selector(addPlayerButtonTapped), for: .touchUpInside)
        addPlayerButton.translatesAutoresizingMaskIntoConstraints = false
        
        historyButton.setTitle("History", for: .normal)
        historyButton.backgroundColor = .systemGreen
        historyButton.addTarget(self, action: #selector(showHistory), for: .touchUpInside)
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(addPlayerButton)
        view.addSubview(historyButton)
    }

    func setupGameOverLabel() {
        gameOverLabel.textAlignment = .center
        gameOverLabel.textColor = .red
        gameOverLabel.font = UIFont.boldSystemFont(ofSize: 18)
        gameOverLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gameOverLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: historyButton.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: gameOverLabel.topAnchor, constant: -20),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            addPlayerButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            addPlayerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addPlayerButton.widthAnchor.constraint(equalToConstant: 100),
            addPlayerButton.heightAnchor.constraint(equalToConstant: 50),
            
            historyButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            historyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            historyButton.widthAnchor.constraint(equalToConstant: 100),
            historyButton.heightAnchor.constraint(equalToConstant: 50),
            
            gameOverLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            gameOverLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameOverLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            gameOverLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc func addPlayerButtonTapped() {
        if !gameStarted && players.count < 8 {
            addPlayer(index: players.count + 1)
        }
    }

    func addPlayer(index: Int) {
        let player = PlayerView(index: index, viewController: self)
        contentView.addSubview(player)
        players.append(player)
        layoutPlayers()
    }

    @objc func showHistory() {
        let historyVC = HistoryViewController(history: history)
        present(historyVC, animated: true, completion: nil)
    }

    func layoutPlayers() {
        var lastBottomAnchor = contentView.topAnchor
        for player in players {
            player.removeFromSuperview()
        }
        for player in players {
            contentView.addSubview(player)
            player.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                player.topAnchor.constraint(equalTo: lastBottomAnchor, constant: 10),
                player.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                player.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                player.heightAnchor.constraint(equalToConstant: 100)
            ])
            lastBottomAnchor = player.bottomAnchor
        }

        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: lastBottomAnchor, constant: -10)
        ])
    }

    func updateLifeLabels() {
        for player in players {
            player.updateLifeLabel()
        }
        checkForGameOver()
    }
    
    func checkForGameOver() {
        for player in players where player.life <= 0 {
            gameOverLabel.text = "Player \(player.index) LOSES!"
            gameStarted = true
            addPlayerButton.isEnabled = false
            break
        }
    }

    func recordHistory(_ entry: String) {
        history.append(entry)
        gameStarted = true
        addPlayerButton.isEnabled = false
        if let historyVC = presentedViewController as? HistoryViewController {
            historyVC.updateHistory(history)
        }
    }

    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
