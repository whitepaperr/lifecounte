//
//  HistoryViewController.swift
//  Life Counter
//
//  Created by 이하은 on 4/18/24.
//

import UIKit

class HistoryViewController: UIViewController {
    var history: [String]
    var textView = UITextView()

    init(history: [String]) {
        self.history = history
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTextView()
    }

    private func setupTextView() {
        view.addSubview(textView)
        textView.text = history.joined(separator: "\n")
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func updateHistory(_ newHistory: [String]) {
        history = newHistory
        textView.text = history.joined(separator: "\n")
    }
}
