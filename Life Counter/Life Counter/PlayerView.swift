//
//  PlayerView.swift
//  Life Counter
//
//  Created by 이하은 on 4/18/24.
//

import UIKit

class PlayerView: UIView {
    var life = 20
    var lifeLabel = UILabel()
    var lifeInputField = UITextField()
    let index: Int
    weak var viewController: ViewController?

    init(index: Int, viewController: ViewController) {
        self.index = index
        self.viewController = viewController
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .lightGray
        layer.cornerRadius = 10
        
        lifeLabel.text = "Player \(index) Life: \(life)"
        lifeLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lifeLabel)
        
        lifeInputField.placeholder = "Enter life change"
        lifeInputField.keyboardType = .numberPad
        lifeInputField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lifeInputField)
        
        let incrementButton = UIButton(type: .system)
        incrementButton.setTitle("+", for: .normal)
        incrementButton.addTarget(self, action: #selector(adjustLife), for: .touchUpInside)
        
        let decrementButton = UIButton(type: .system)
        decrementButton.setTitle("-", for: .normal)
        decrementButton.addTarget(self, action: #selector(adjustLife), for: .touchUpInside)
        
        let buttonStack = UIStackView(arrangedSubviews: [incrementButton, decrementButton])
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            lifeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            lifeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            lifeInputField.topAnchor.constraint(equalTo: lifeLabel.bottomAnchor, constant: 10),
            lifeInputField.centerXAnchor.constraint(equalTo: centerXAnchor),
            lifeInputField.widthAnchor.constraint(equalToConstant: 100),
            buttonStack.topAnchor.constraint(equalTo: lifeInputField.bottomAnchor, constant: 10),
            buttonStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonStack.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func adjustLife(sender: UIButton) {
        let adjustment = Int(lifeInputField.text ?? "") ?? 0
        let sign = sender.currentTitle == "+" ? 1 : -1
        let changeAmount = sign * adjustment
        life += changeAmount
        let action = changeAmount > 0 ? "gained" : "lost"
        viewController?.recordHistory("Player \(index) \(action) \(abs(changeAmount)) life.")
        viewController?.updateLifeLabels()
    }
    
    func updateLifeLabel() {
        lifeLabel.text = "Player \(index) Life: \(life)"
    }
}
