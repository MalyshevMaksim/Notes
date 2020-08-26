//
//  DetailNoteController.swift
//  JustNote
//
//  Created by Малышев Максим Алексеевич on 8/24/20.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit
import RichEditorView

class DetailNoteController: UIViewController {
    var note: Note!
    var titleTextField: UITextView!
    var bodyTextField: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        titleTextField = UITextView(frame: CGRect(x: 15, y: 100, width: 320, height: 100))
        titleTextField.text = "\(note.title!)"
        titleTextField.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        
        bodyTextField = UITextView(frame: CGRect(x: 15, y: 100, width: 320, height: 100))
        bodyTextField.text = "\(note.body!)"
        bodyTextField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        bodyTextField.textAlignment = .justified
        
        setup()
    }
    
    private func setup() {
        view.addSubview(titleTextField)
        view.addSubview(bodyTextField)
        
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            //bodyTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10)
        ])
    }
}
