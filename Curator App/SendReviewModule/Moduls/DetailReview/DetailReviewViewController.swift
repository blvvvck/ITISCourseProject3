//
//  DetailReviewViewController.swift
//  CourseProject
//
//  Created by BLVCK on 16/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit
import DLRadioButton
import ILPDFKit

class DetailReviewViewController: UIViewController, ModuleInput, ModuleInputHolder, UITextViewDelegate {
    var moduleInput: ModuleInput?
    
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var radioBtn: DLRadioButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var highCompetentionRadioButton: DLRadioButton!
    @IBOutlet weak var responsibilityRadioButton: DLRadioButton!
    @IBOutlet weak var independenceRadioButton: DLRadioButton!
    @IBOutlet weak var dignityTextView: UITextView!
    @IBOutlet weak var directionRadioButton: DLRadioButton!
    @IBOutlet weak var workRatingRadioButton: DLRadioButton!
    @IBOutlet weak var textWorkRadioButton: DLRadioButton!
    @IBOutlet weak var completeWorkRadioButton: DLRadioButton!
    @IBOutlet weak var constraintTextViewToMerk: NSLayoutConstraint!
    @IBOutlet weak var constraintTextViewToOther: NSLayoutConstraint!
    @IBOutlet weak var constraintOtherToMark: NSLayoutConstraint!
    @IBOutlet weak var otherDignityRadioButton: DLRadioButton!
    @IBOutlet weak var constraintDignityTextViewToOther: NSLayoutConstraint!
    @IBOutlet weak var constraintOtherDignityToLimitations: NSLayoutConstraint!
    @IBOutlet weak var contraintDignityTextViewToLimitations: NSLayoutConstraint!
    
    let studentDbManager = StudentDbManager()
    var id = 0
    var student: Student!
    let settingsDbManager = DbManagerImplementation()
    var settings: SettingsModel!
    var realizationMark = "5"
    var textMark = "5"
    var completeMark = "5"
    var limitationHelper = ""
   
    override func viewDidLoad() {
        super.viewDidLoad()
        themeLabel.text = "dsadsadsadsadhsadasbduasbduasbdhasbdjhasbdasbdjsahbdja"
        constraintTextViewToMerk.priority = .defaultLow
        constraintTextViewToOther.priority = .defaultLow
        constraintOtherToMark.priority = .defaultHigh
        //constraintDignityTextViewToOther.priority = .defaultLow
        //contraintDignityTextViewToLimitations.priority = .defaultLow
        //constraintOtherDignityToLimitations.priority = .defaultHigh
        //dignityTextView.isHidden = true
        textView.isHidden = true
        radioBtn.isSelected = true
        moduleInput = self
        student = studentDbManager.getStudentById(with: id)
        workRatingRadioButton.isSelected = true
        settings = settingsDbManager.getDataFromDB()
        // Do any additional setup after loading the view.
        prepareStudentInfo()
        highCompetentionRadioButton.titleLabel?.numberOfLines = 0
        responsibilityRadioButton.titleLabel?.numberOfLines = 0
        otherDignityRadioButton.isSelected = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(actionTap))
        self.view.addGestureRecognizer(gesture)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: Notification.Name.UIResponder.keyboardWillHideNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: Notification.Name.UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: Notification.add, object: <#T##Any?#>)
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
    
    @objc func actionTap() {
        if (textView.isFirstResponder || dignityTextView.isFirstResponder ) {
            textView.resignFirstResponder()
            dignityTextView.resignFirstResponder()
        }
    }
    
    func prepareStudentInfo() {
        nameLabel.text = student.name
        groupLabel.text = student.group
        themeLabel.text = student.theme
    }
    
    func prepareRadioButtons() {
        radioBtn.isMultipleSelectionEnabled = false
        radioBtn.isMultipleTouchEnabled = false
        completeWorkRadioButton.isMultipleSelectionEnabled = false
        completeWorkRadioButton.isMultipleTouchEnabled = false
        workRatingRadioButton.isMultipleSelectionEnabled = false
        workRatingRadioButton.isMultipleTouchEnabled = false
        textWorkRadioButton.isMultipleSelectionEnabled = true
        textWorkRadioButton.isMultipleTouchEnabled = true
        directionRadioButton.isMultipleSelectionEnabled = false
        directionRadioButton.isMultipleTouchEnabled = false
        independenceRadioButton.isMultipleTouchEnabled = true
    }
    
    
    @IBAction func radioButtonTapped(_ sender: DLRadioButton) {
        if sender.tag == 1 {
            limitationHelper = "Не выявлено"
            print("Не выявлено")
            textView.isHidden = true
            constraintTextViewToMerk.priority = .defaultLow
            constraintTextViewToOther.priority = .defaultLow
            constraintOtherToMark.priority = .defaultHigh
        }
        if sender.tag == 2 {
            print(sender.titleLabel?.text)
            print("Другое")
            textView.isHidden = false
            limitationHelper = "Другое"
            
            constraintTextViewToMerk.priority = .defaultHigh
            constraintTextViewToOther.priority = .defaultHigh
            constraintOtherToMark.priority = .defaultLow
        }
        if (sender.tag == 3) {
            print(sender.titleLabel?.text)
            print("Другие достоинства")
            dignityTextView.isHidden = false
            
            constraintDignityTextViewToOther.priority = .defaultHigh
            contraintDignityTextViewToLimitations.priority = .defaultHigh
            constraintOtherDignityToLimitations.priority = .defaultLow
            
            independenceRadioButton.isSelected = false
            responsibilityRadioButton.isSelected = false
            highCompetentionRadioButton.isSelected = false
            
        }
        
        if (sender.tag == 4 || sender.tag == 5 || sender.tag == 6) {
            dignityTextView.isHidden = true
            
            constraintDignityTextViewToOther.priority = .defaultLow
            contraintDignityTextViewToLimitations.priority = .defaultLow
            constraintOtherDignityToLimitations.priority = .defaultHigh
            
            otherDignityRadioButton.isSelected = false
        }
        
        if (sender.tag == 10) {
            realizationMark = "5"
        } else if (sender.tag == 11) {
            realizationMark = "4"
        } else if (sender.tag == 12) {
            realizationMark = "3"
        }
        
        if (sender.tag == 14) {
            textMark = "5"
        } else  if (sender.tag == 15) {
            textMark = "4"
        } else if (sender.tag == 16) {
            textMark = "3"
        }
        
        if (sender.tag == 18) {
            completeMark = "5"
        } else if (sender.tag == 19) {
            completeMark = "4"
        } else if (sender.tag == 20) {
            completeMark = "3"
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setData(_ data: Any?) {
        guard let index = data as? Int else {return}
        let student = studentDbManager.getStudentById(with: index)
        themeLabel.text = student.theme
        
    }
    

    @IBAction func generate(_ sender: Any) {
        let pdfReview = CompleteReviewViewController()
        var limitationsText = "Существенных недостатков в работе выявлено не было"
        var conclusionText = "5"
        var dignityText = "5"
        if limitationHelper == "Не выявлено" {
            limitationsText = "Существенных недостатков в работе выявлено не было"
        } else if limitationHelper == "Другое" {
            limitationsText = textView.text
        }
        
        if completeMark == "5" {
            conclusionText = "Данная работа заслуживает оценки \("«")отлично\("»")"
        } else if completeMark == "4" {
            conclusionText = "Данная работа заслуживает оценки \("«")хорошо\("»")"
        } else if completeMark == "3" {
            conclusionText = "Данная работа заслуживает оценки \("«")удовлетворительно\("»")"
        }
        
        if (independenceRadioButton.isSelected == true && responsibilityRadioButton.isSelected == false && highCompetentionRadioButton.isSelected == false) {
            dignityText = "В рамках работы над курсовым проектом студент продемонстрировал самостоятельность"
        } else if (responsibilityRadioButton.isSelected == true && independenceRadioButton.isSelected == false && highCompetentionRadioButton.isSelected == false ) {
            dignityText = "В рамках работы над курсовым проектом студент продемонстрировал ответственный подход к решению поставленных задач"
        } else if (highCompetentionRadioButton.isSelected == true && independenceRadioButton.isSelected == false && responsibilityRadioButton.isSelected == false) {
            dignityText = "В рамках работы над курсовым проектом продемонстрировал высокий уровень профессиональных компетенций"
        } else if (independenceRadioButton.isSelected == true && responsibilityRadioButton.isSelected == true && highCompetentionRadioButton.isSelected == false) {
            dignityText = "В рамках работы над курсовым проектом студент продемонстрировал самостоятельность и ответственный подход к решению поставленных задач"
        } else if (independenceRadioButton.isSelected == true && responsibilityRadioButton.isSelected == false && highCompetentionRadioButton.isSelected == true) {
            dignityText = "В рамках работы над курсовым проектом студент продемонстрировал самостоятельность и высокий уровень профессиональных компетенций"
        } else if (independenceRadioButton.isSelected == false && responsibilityRadioButton.isSelected == true && highCompetentionRadioButton.isSelected == true) {
            dignityText = "В рамках работы над курсовым проектом студент продемонстрировал ответственный подход к решению поставленных задач и высокий уровень профессиональных компетенций"
        } else if (independenceRadioButton.isSelected == true && responsibilityRadioButton.isSelected == true && highCompetentionRadioButton.isSelected == true) {
            dignityText = "В рамках работы над курсовым проектом студент продемонстрировал самостоятельность, ответственный подход к решению поставленных задач и высокий уровень профессиональных компетенций"
        } else if (independenceRadioButton.isSelected == false && responsibilityRadioButton.isSelected == false && highCompetentionRadioButton.isSelected == false && otherDignityRadioButton.isSelected == true) {
            dignityText = dignityTextView.text
        }
        
        if dignityText == "" {
            let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
            
        let reviewModel = ReviewModel(theme: student.theme, studentName: student.name, institute: "Высшая школа информационных технологий и информационных систем", direction: (directionRadioButton.titleLabel?.text)!, mentor: settings.mentor, workRating: realizationMark, textRating: textMark, dignity: dignityText, limitations: limitationsText, conclusion: conclusionText, studentEmail: student.email, studentId: student.id)
        
        pdfReview.reviewModel = reviewModel
        navigationController?.pushViewController(pdfReview as! UIViewController, animated: true)
    }

}
