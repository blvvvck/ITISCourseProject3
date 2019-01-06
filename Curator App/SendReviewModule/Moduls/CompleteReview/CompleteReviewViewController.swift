//
//  CompleteReviewViewController.swift
//  CourseProject
//
//  Created by BLVCK on 09/05/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit
import ILPDFKit
import MessageUI

class CompleteReviewViewController: ILPDFViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var pdf: ILPDFView!
    var reviewModel: ReviewModel!
    var data: Data!
    var studentDbManager = StudentDbManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let sendButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(showMailComposer))
        let sendButton = UIButton(type: .custom)
        sendButton.titleLabel?.text = "Отправить"
        sendButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        sendButton.addTarget(self, action: #selector(showMailComposer), for: .touchUpInside)
        let sendBarButtonItem = UIBarButtonItem(customView: sendButton)
        self.navigationController?.navigationItem.setRightBarButton(sendBarButtonItem, animated: true)
        self.navigationController?.navigationItem.rightBarButtonItem?.title = "Send"
        self.navigationController?.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        self.navigationController?.navigationItem.rightBarButtonItem?.isEnabled = true
        self.navigationItem.setRightBarButton(sendBarButtonItem, animated: true)
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        print(self.navigationController?.navigationBar.items)
        
        let homeBtn: UIButton = UIButton(type: UIButton.ButtonType.custom)
        
        homeBtn.setImage(UIImage(named: "send-button"), for: [])
        
        homeBtn.addTarget(self, action: #selector(showMailComposer), for: UIControl.Event.touchUpInside)
        
        homeBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let homeButton = UIBarButtonItem(customView: homeBtn)
        self.navigationItem.setRightBarButton(homeButton, animated: true)

        
        let document = ILPDFDocument(resource:"courseProject23.pdf")
        self.document = document
        
        let studentNameForm = document.forms.forms(withName: "studentName")
        studentNameForm.first?.value = reviewModel.studentName
        
        //заполнение темы
        let themeCharacters = Array(reviewModel.theme)
        let themeArray = reviewModel.theme.split(separator: " ")
        var firstTheme  = [""]
        var secondTheme = [""]
        var count = 0
        if themeCharacters.count > 60 {
            for element in themeArray {
                if count < 60 {
                    count += element.count
                    firstTheme.append(String(element))
                } else if count >= 60 {
                    secondTheme.append(String(element))
                }
            }
            let themeForm = document.forms.forms(withName: "theme1")
            var test1 = firstTheme.map { String($0)
                }.joined(separator: " ")
            themeForm.first?.value = String(test1)
            
            let theme2Form = document.forms.forms(withName: "theme2")
            var test2 = secondTheme.map { String($0)
                }.joined(separator: " ")
            theme2Form.first?.value = String(test2)
        } else {
            let themeForm = document.forms.forms(withName: "theme1")
            themeForm.first?.value = reviewModel.theme
        }
        
        //заполнение достоинств
        let advantagesCharacters = Array(reviewModel.dignity)
        let advantagesArray = reviewModel.dignity.split(separator: " ")
        var firstAdvantages  = [""]
        var secondAdvantages = [""]
        var thirdAdvantages = [""]
        var countAdvantages = 0
        if advantagesCharacters.count > 50 && advantagesCharacters.count <= 125 {
            for element in advantagesArray {
                if countAdvantages < 50 {
                    countAdvantages += element.count
                    firstAdvantages.append(String(element))
                } else if countAdvantages >= 50 {
                    secondAdvantages.append(String(element))
                }
            }
        }

        if advantagesCharacters.count > 125 {
            for element in advantagesArray {
                if countAdvantages < 50 {
                    countAdvantages += element.count
                    firstAdvantages.append(String(element))
                } else if countAdvantages >= 50 && countAdvantages < 125 {
                    countAdvantages += element.count
                    secondAdvantages.append(String(element))
                } else if countAdvantages > 125 {
                    thirdAdvantages.append(String(element))
                }
            }
        }

        let advantagesForm = document.forms.forms(withName: "advantages1")
        var advantagesText1 = firstAdvantages.map { String($0)
            }.joined(separator: " ")
        advantagesForm.first?.value = String(advantagesText1)

        let advantagesForm2 = document.forms.forms(withName: "advantages2")
        var advantagesText2 = secondAdvantages.map { String($0)
            }.joined(separator: " ")
        advantagesForm2.first?.value = String(advantagesText2)

        let advantagesForm3 = document.forms.forms(withName: "advantages3")
        var advantagesText3 = thirdAdvantages.map { String($0)}.joined(separator: " ")
        advantagesForm3.first?.value = String(advantagesText3)
        
        if advantagesCharacters.count <= 50 {
            let advantagesFrom = document.forms.forms(withName: "advantages1")
            advantagesFrom.first?.value = reviewModel.dignity
        }
        
        //заполнение недостатков
        let limitationsCharacters = Array(reviewModel.limitations)
        let limitationsArray = reviewModel.limitations.split(separator: " ")
        var firstLimitations  = [""]
        var secondLimitations = [""]
        var thirdLimitations = [""]
        var countLimitations = 0
        if limitationsCharacters.count > 50 && limitationsCharacters.count <= 125 {
            for element in limitationsArray {
                if countLimitations < 50 {
                    countLimitations += element.count
                    firstLimitations.append(String(element))
                } else if countLimitations >= 50 {
                    secondLimitations.append(String(element))
                }
            }
        }
        
        if limitationsCharacters.count > 125 {
            for element in advantagesArray {
                if countLimitations < 50 {
                    countLimitations += element.count
                    firstLimitations.append(String(element))
                } else if countLimitations >= 50 && countLimitations < 125 {
                    countLimitations += element.count
                    secondLimitations.append(String(element))
                } else if countLimitations > 125 {
                    thirdLimitations.append(String(element))
                }
            }
        }
        
        let limitationForm1 = document.forms.forms(withName: "limitations1")
        var limitationText1 = firstLimitations.map { String($0)
            }.joined(separator: " ")
        limitationForm1.first?.value = String(limitationText1)
        
        let limitationForm2 = document.forms.forms(withName: "limitations2")
        var limitationText2 = secondLimitations.map { String($0)
            }.joined(separator: " ")
        limitationForm2.first?.value = String(limitationText2)
        
        let limitationForm3 = document.forms.forms(withName: "limitations3")
        var limitationText3 = thirdLimitations.map { String($0)}.joined(separator: " ")
        limitationForm3.first?.value = String(limitationText3)

        
        if limitationsCharacters.count <= 50 {
            let limitationForm = document.forms.forms(withName: "limitations1")
            limitationForm.first?.value = reviewModel.limitations
        }
//        let limitationsForm = document.forms.forms(withName: "limitations1")
//        limitationsForm.first?.value = reviewModel.limitations
        
        let conclusionForm = document.forms.forms(withName: "conclusion1")
        conclusionForm.first?.value = reviewModel.conclusion
        
        let instituteForm = document.forms.forms(withName: "institute")
        instituteForm.first?.value = reviewModel.institute
        
        let directionForm = document.forms.forms(withName: "directionOfTraining")
        directionForm.first?.value = reviewModel.direction
        
        let mentorForm = document.forms.forms(withName: "mentor")
        mentorForm.first?.value = reviewModel.mentor
        
        if reviewModel.textRating == "5" {
            let textForm = document.forms.forms(withName: "text_5")
            for element in textForm {
                element.value = "+"
            }
        } else if reviewModel.textRating == "4" {
            let textForm = document.forms.forms(withName: "text_4")
            for element in textForm {
                element.value = "+"
            }
        } else if reviewModel.textRating == "3" {
            let textForm = document.forms.forms(withName: "text_3")
            for element in textForm {
                element.value = "+"
            }
        }
        
        if reviewModel.workRating == "5" {
            let textForm = document.forms.forms(withName: "realization_5")
            for element in textForm {
                element.value = "+"
            }
        } else if reviewModel.workRating == "4" {
            let textForm = document.forms.forms(withName: "realization_4")
            for element in textForm {
                element.value = "+"
            }
        } else if reviewModel.workRating == "3" {
            let textForm = document.forms.forms(withName: "realization_3")
            for element in textForm {
                element.value = "+"
            }
        }
        
//        let realization = document.forms.forms(withName: "realization_4")
//        let text = document.forms.forms(withName: "text_3")
//        for test in realization {
//            test.value = "+"
//        }
//        for test in text {
//            test.value = "+"
//        }
        
        let data = self.document?.savedStaticPDFData()
        self.data = data
        
        let savedVCDocument = ILPDFDocument(data: data!)
        
        self.document = savedVCDocument
        
        print(self.pdfView?.pdfView.frame)
        self.pdfView?.pdfView.scrollView.backgroundColor = UIColor.white
        self.pdfView?.pdfView.scrollView.tintColor = UIColor.white
        print(self.pdfView?.pdfView.subviews)

        print(reviewModel)
        
    }
    
    @objc func showMailComposer() {
        if MFMailComposeViewController.canSendMail() {
            let subject = "Отзыв руководителя курсовой"
            let messageBody = "Отзыв руководителя курсовой"
            let toRecipients = [reviewModel.studentEmail]
            
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            mailComposer.setSubject(subject)
            mailComposer.setMessageBody(messageBody, isHTML: false)
            mailComposer.setToRecipients(toRecipients)
            mailComposer.addAttachmentData(data, mimeType: "application/pdf", fileName: "Отзыв")
            //present(mailComposer, animated: true, completion: nil)
            //self.navigationController?.present(mailComposer, animated: true, completion: nil)
            UIApplication.shared.keyWindow?.rootViewController?.present(mailComposer, animated: true)
            // ТУТ ПРОБЛЕМА

        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            alert(title: "Ooops", msg: "Mail cancelled")
        case MFMailComposeResult.sent.rawValue:
            alert(title: "Yes!", msg: "Mail sent")
            print("ОТПРАВЛЕНО")
            studentDbManager.setStudentAsCompleted(with: reviewModel.studentId)
            //let vc = FirstCourseViewController()
            //vc.studentCourse = "2"
            //self.navigationController?.popToRootViewController(animated: true)
        case MFMailComposeResult.saved.rawValue:
            alert(title: "Yes!", msg: "Mail saved")
        case MFMailComposeResult.failed.rawValue:
            alert(title: "Ooops", msg: "Mail failed")
        default:
            break
        }
        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func alert(title: String, msg: String) {
        let alertConntroller = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alertConntroller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertConntroller, animated: true, completion: nil)
    }

}

