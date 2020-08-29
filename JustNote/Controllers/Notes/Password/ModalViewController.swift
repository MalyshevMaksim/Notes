//
//  ModalViewController.swift
//  JustNote
//
//  Created by Малышев Максим Алексеевич on 8/28/20.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit
import Locksmith

class ModalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var serviceTextField = UITextField()
    var loginTextField = UITextField()
    var passwordTextField = UITextField()
    var imagePicker = UIImagePickerController()
    var imageS: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Adding a note"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        
        serviceTextField.placeholder = "Service"
        loginTextField.placeholder = "Login"
        passwordTextField.placeholder = "Password"
        
        serviceTextField.borderStyle = .roundedRect
        loginTextField.borderStyle = .roundedRect
        passwordTextField.borderStyle = .roundedRect
        
        serviceTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 20)
        button.setTitle("CHOSE IMAGE", for: .normal)
        button.addTarget(self, action: #selector(chooseImage), for: .touchUpInside)
        
        view.addSubview(serviceTextField)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            serviceTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            serviceTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            serviceTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            loginTextField.topAnchor.constraint(equalTo: serviceTextField.bottomAnchor, constant: 10),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func chooseImage() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imageS = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancelAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func doneAction() {
        dismiss(animated: true) {
            let pass = PasswordNote(context: CoreDataStack.shared.managedContext)
            pass.title = self.serviceTextField.text
            pass.date = Date()
            pass.id = UUID()
            pass.section = "Others"
            pass.image = self.imageS
            
            let dict = ["Login" : self.loginTextField.text!, "Password" : self.passwordTextField.text!]
            try! Locksmith.saveData(data: dict, forUserAccount: "\(pass.id!)")
            CoreDataStack.shared.saveContext()
        }
    }
}
