//
//  SettingsViewController.swift
//  CourseProject
//
//  Created by BLVCK on 12/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, SettingsViewInput, UITextFieldDelegate {
    
    @IBOutlet weak var mentorTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var sheetNameTextField: UITextField!
    @IBOutlet weak var rangeTextField: UITextField!
    var presenter: SettingsViewOutput!
    @IBOutlet weak var scrollView: UIScrollView!
    var activeTextField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewIsReady()
        mentorTextField.delegate = self
        linkTextField.delegate = self
        
        mentorTextField.returnKeyType = UIReturnKeyType.done
        linkTextField.returnKeyType = UIReturnKeyType.done
        
        linkTextField.enablesReturnKeyAutomatically = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(actionTap))
        self.view.addGestureRecognizer(gesture)
    }
    
    @objc func actionTap() {
        if (mentorTextField.isFirstResponder || linkTextField.isFirstResponder || sheetNameTextField.isFirstResponder || rangeTextField.isFirstResponder) {
            mentorTextField.resignFirstResponder()
            linkTextField.resignFirstResponder()
            rangeTextField.resignFirstResponder()
            sheetNameTextField.resignFirstResponder()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: Notification.Name.UIResponder.keyboardWillHideNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: Notification.Name.keyboardWillShowNotification, object: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillAppear(_ notification: NSNotification) {
       
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 40
        scrollView.contentInset = contentInset

        
    }
    
    @objc func keyboardWillDisappear(_ notification: NSNotification) {
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setMentor(with mentor: String) {
        mentorTextField.text = mentor
    }
    
    func setLink(with link: String) {
        linkTextField.text = link
    }
    
    func setSheetName(with sheetName: String) {
        sheetNameTextField.text = sheetName
    }
    
    func setRange(with range: String) {
        rangeTextField.text = range
    }
   
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        presenter.saveSettings(with: mentorTextField.text!, and: linkTextField.text!, and: sheetNameTextField.text!, and: rangeTextField.text!)
    }
    
    func dismisToStudent() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
