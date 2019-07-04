//
//  ProposerViewController.swift
//  TripHunters
//
//  Created by oscar Amzalag on 28/06/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import UIKit

class ProposerViewController: UITableViewController, CategoryPickerDelegate {
    //MARK:- Properties
    var activityCategory: ActivityType = .Cultural
    
    //MARK:- Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var adresseTextField: UITextField!
    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var createButton: UIBarButtonItem!
    @IBOutlet weak var clearButton: UIBarButtonItem!
    
    //MARK:- Actions
    @IBAction func addImage(_ sender: Any) {
        pickAnImage()
    }
    
    @IBAction func textDidChangeuserTypedText(_ sender: Any) {
        displayCreateButton()
    }
    
    @IBAction func clearAll(_ sender: Any) {
        titleTextField.text = nil
        adresseTextField.text = nil
        activityImageView.image = nil
        activityImageView.isHidden = false
        addImageButton.isHidden = false
        descriptionTextView.text = nil
        categoryLabel.text = "Catégories"
        createButton.isEnabled = false
        clearButton.isEnabled = false
    }
    
    @IBAction func createButton(_ sender: Any) {
            createActivity()
            presentAlert(title: "Activité ajoutée", message: "Retrouvez la dans votre profil")
    }
    
    //MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        longPressGestureRecognizer()
        titleTextField.delegate = self
        adresseTextField.delegate = self
        descriptionTextView.delegate = self
        createButton.isEnabled = false
        clearButton.isEnabled = false
    }
    
    func createActivity() {
        guard let image = activityImageView.image else { return }
        guard let description = descriptionTextView.text else { return }
        guard let activityName = titleTextField.text else { return }
        guard let adresse = adresseTextField.text else { return }
        
        let activity = Activity(idActivity: 0, idUser: 0, nameActivity: activityName, descriptionActivity: description, typeActivity: activityCategory, adresse: adresse, country: "FR", gpsx: 0, gpsy: 0, showActivity: true, imageDesc: [image])
        print(activity)
    }
    
    func displayCreateButton() {
        if titleTextField.text != nil && titleTextField.text != ""
            && adresseTextField.text != nil && adresseTextField.text != ""
            && descriptionTextView.text != nil && descriptionTextView.text.count >= 3
            && activityImageView.image != nil
            && categoryLabel.text != "Catégories"
        {
            createButton.isEnabled = true
        } else {
            createButton.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as? TypeActivityTableViewController
        destinationViewController?.delegate = self
    }
    
    func didSelectCategory(type: ActivityType) {
        activityCategory = type
        categoryLabel.text = type.name()
        displayCreateButton()
        clearButton.isEnabled = true
    }
    
    /**
     * Get image from Photo Library
     */
    private func pickAnImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        present(imagePickerController, animated: true, completion: nil)
    }
    
    private func longPressGestureRecognizer() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(gesture:)))
        activityImageView.addGestureRecognizer(longPress)
    }
    
    /**
     * Allow to delete picture by long press gesture on it
     */
    @objc private func longPressed(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .ended { return }
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        let deleteAction = UIAlertAction(title: "Supprimer", style: .destructive, handler: { (action) -> Void in
            self.activityImageView.image = nil // delete image
            self.addImageButton.isHidden = false // show picture selection button
        })
        alert.addAction(deleteAction)
        present(alert, animated: true, completion: nil)
    }
}


extension ProposerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            activityImageView.image = image
            addImageButton.isHidden = true
        }
        dismiss(animated: true, completion: nil)
        displayCreateButton()
        clearButton.isEnabled = true
    }
}

// Dismiss Keyboard
extension ProposerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension ProposerViewController: UITextViewDelegate {
    
    
    func textViewDidChange(_ textView: UITextView) {
        print("tv change")

        displayCreateButton()
        clearButton.isEnabled = true
    }
}

// UIAlertController
extension ProposerViewController {
    func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
