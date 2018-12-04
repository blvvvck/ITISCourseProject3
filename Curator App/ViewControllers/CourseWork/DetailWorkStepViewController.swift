//
//  DetailWorkStepViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 28/11/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class DetailWorkStepViewController: UIViewController {
    
    // MARK: - Nested Types
    
    enum DetailWorkStepControllerType {
        case watch
        case edit
    }
    
    
    // MARK: - Intance Properties
    
    @IBOutlet weak var stepNameTextField: UITextField!
    
    @IBOutlet weak var stepStartDateTextField: UITextField!
    
    @IBOutlet weak var stepEndDateTextField: UITextField!
    
    @IBOutlet weak var stepDescriptionTextView: UITextView!
    
    @IBOutlet weak var stepMaterialsTextView: UITextView!
    // MARK: -
    
    var type: DetailWorkStepControllerType!
    
    fileprivate var startDatePicker: UIDatePicker!
    fileprivate var endDatePicker: UIDatePicker!
    
    // MARK: - Instance Methods
    
    fileprivate func configureUI() {
        switch self.type {
        case .watch?:
            self.stepNameTextField.isUserInteractionEnabled = false
            self.stepStartDateTextField.isUserInteractionEnabled = false
            self.stepEndDateTextField.isUserInteractionEnabled = false
            self.stepDescriptionTextView.isUserInteractionEnabled = false
            self.stepMaterialsTextView.isUserInteractionEnabled = false
            
        case .edit?:
            self.stepNameTextField.isUserInteractionEnabled = true
            self.stepStartDateTextField.isUserInteractionEnabled = true
            self.stepEndDateTextField.isUserInteractionEnabled = true
            self.stepDescriptionTextView.isUserInteractionEnabled = true
            self.stepMaterialsTextView.isUserInteractionEnabled = true
            
        default:
            return
        }
    }
    
    fileprivate func configureNavigationBar() {
        switch self.type {
        case .watch?:
            let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(onEditButtonTouchUpInside))
            
            self.navigationItem.rightBarButtonItem = editButton
            
        default:
            return
        }
        
    }
    
    fileprivate func configureTextFields() {
        self.startDatePicker = UIDatePicker()
        self.endDatePicker = UIDatePicker()
        
        self.startDatePicker.datePickerMode = .date
        self.endDatePicker.datePickerMode = .date
        
        self.startDatePicker.addTarget(self, action: #selector(startDateChanged(datePicker:)), for: .valueChanged)
        self.endDatePicker.addTarget(self, action: #selector(endDateChanged(datePicker:)), for: .valueChanged)
        
        self.stepStartDateTextField.inputView = self.startDatePicker
        self.stepEndDateTextField.inputView = self.endDatePicker
    }
    
    @objc
    private func onEditButtonTouchUpInside() {
        let detailStepVC = self.storyboard?.instantiateViewController(withIdentifier: "detailWorkStepVC") as! DetailWorkStepViewController
        
        detailStepVC.type = DetailWorkStepViewController.DetailWorkStepControllerType.edit
        
        self.navigationController?.pushViewController(detailStepVC, animated: true)
    }
    
    @objc
    fileprivate func startDateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.stepStartDateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc
    fileprivate func endDateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.stepEndDateTextField.text = dateFormatter.string(from: datePicker.date)
    }
   
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureUI()
        self.configureNavigationBar()
        self.configureTextFields()
    }
}
