//
//  DetailNoteController.swift
//  JustNote
//
//  Created by Малышев Максим Алексеевич on 8/24/20.
//  Copyright © 2020 Максим. All rights reserved.
//

import UIKit

class DetailNoteController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var note: Note!
    var bodyTextField: UITextView!
    var attachedImages: [UIImage]!
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bodyTextField = UITextView(frame: CGRect(x: 15, y: 100, width: 320, height: 100))
        bodyTextField.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        
        let fullString = NSMutableAttributedString(string: "Start of text")
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = UIImage(named: "eminem")
        let image1String = NSAttributedString(attachment: image1Attachment)
        fullString.append(image1String)
        fullString.append(NSAttributedString(string: "End of text"))
        
        bodyTextField.attributedText = fullString
        setup()
        configureController()
    }
    
    private func configureController() {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(addImage))
    }
    
    @objc private func addImage() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            let image = Image(context: CoreDataStack.shared.managedContext)
            image.image = pickedImage
            note.addToImages(image)
            CoreDataStack.shared.saveContext()
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func setup() {
        view.addSubview(bodyTextField)
        
        NSLayoutConstraint.activate([
            bodyTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            bodyTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            bodyTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
}
