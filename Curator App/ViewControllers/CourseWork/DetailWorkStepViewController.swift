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
        case add
    }
    
    
    // MARK: - Intance Properties
    
    @IBOutlet weak var stepNameTextField: UITextField!
    
    @IBOutlet weak var stepStartDateTextField: UITextField!
    
    @IBOutlet weak var stepEndDateTextField: UITextField!
    
    @IBOutlet weak var stepDescriptionTextView: UITextView!
    
    @IBOutlet weak var stepMaterialsTextView: UITextView!
    
    @IBOutlet weak var emptyStateContainerView: UIView!
    
    @IBOutlet weak var emptyStateView: EmptyStateView!
    
    // MARK: -
    
    var type: DetailWorkStepControllerType!
    
    fileprivate var startDatePicker: UIDatePicker!
    fileprivate var endDatePicker: UIDatePicker!
    
    var workStep: StepModel!
    var courseWork: CourseWork!
    
    // MARK: - Empty State
    
    fileprivate func showEmptyState(image: UIImage? = nil, title: String, message: String, action: EmptyStateAction? = nil) {
        self.emptyStateView.hideActivityIndicator()
        
        self.emptyStateView.image = image
        self.emptyStateView.title = title
        self.emptyStateView.message = message
        self.emptyStateView.action = action
        
        self.emptyStateContainerView.isHidden = false
    }
    
    fileprivate func hideEmptyState() {
        self.emptyStateContainerView.isHidden = true
    }
    
    fileprivate func showNoDataState() {
        self.showEmptyState(image: #imageLiteral(resourceName: "NoDataStateIcon.pdf"),
                            title: "No data for display",
                            message: "We are already working on correcting this error.")
    }
    
    fileprivate func showLoadingState() {
        if self.emptyStateContainerView.isHidden {
            self.showEmptyState(title: "Loading...",
                                message: "We are loading profile information. Please wait a bit.")
        }
        
        self.emptyStateView.showActivityIndicator()
    }
    
    fileprivate func handle(stateError error: Error, retryHandler: (() -> Void)? = nil) {
        //        let action = EmptyStateAction(title: "Try again".localized(), onClicked: {
        //            retryHandler?()
        //        })
        //
        //        switch error as? WebError {
        //        case .some(.connection), .some(.timeOut):
        //            if self.presets.isEmpty {
        //                self.showEmptyState(image: #imageLiteral(resourceName: "NoConnectionStateIcon.pdf"),
        //                                    title: "No internet connection".localized(),
        //                                    message: "We couldn’t connect to the server. Please check your internet connection and try again.".localized(),
        //                                    action: action)
        //            }
        //
        //        default:
        //            if self.presets.isEmpty {
        //                self.showEmptyState(image: #imageLiteral(resourceName: "ErrorStateIcon.pdf"),
        //                                    title: "Ooops! Something went wrong".localized(),
        //                                    message: "We are already working on correcting this error.".localized(),
        //                                    action: action)
        //            }
        //        }
    }
    
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
            
        case .add?:
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
            
        case .edit?:
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonTouchUpInside))
            
            self.navigationItem.rightBarButtonItem = doneButton
            
        case .add?:
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonTouchUpInside))
            
            self.navigationItem.rightBarButtonItem = doneButton
            
            
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
        detailStepVC.apply(workStep: self.workStep, courseWork: self.courseWork)
        
        self.navigationController?.pushViewController(detailStepVC, animated: true)
    }
    
    @objc
    private func onDoneButtonTouchUpInside() {
        switch self.type {
        case .edit?:
            self.workStep.description = self.stepDescriptionTextView.text
            self.workStep.title = self.stepNameTextField.text!
            self.workStep.date_start = self.stepStartDateTextField.text!
            self.workStep.date_finish = self.stepEndDateTextField.text!
            
            MoyaServices.worksProvider.request(.updateWorkStep(MoyaServices.currentUserId, self.courseWork.id, self.workStep)) { (result) in
                switch result {
                case .success(let response):
                    print("UPDATE WORK STEP SUCCESS")
                    self.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    print("UPDATE WORK STEP ERROR")
                }
            }
            
        case .add?:
            guard let title = self.stepNameTextField.text,
                let stepDescription = self.stepDescriptionTextView.text,
                let startDate = self.stepStartDateTextField.text,
                let endDate = self.stepEndDateTextField.text else { return }
            
            let workStep = StepModel(id: 1, title: title, description: stepDescription, date_start: startDate, date_finish: endDate, status: StepStatusModel(id: 1, name: ""))
            
            MoyaServices.worksProvider.request(.addWorkStep(MoyaServices.currentUserId, self.courseWork.id, workStep)) { (result) in
                switch result {
                case .success(let response):
                    print("ADD WORK STEP SUCCESS")
                    self.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    print("ADD WORK STEP ERROR")
                }
            }
            
        default:
            return
        }
    }
    
    @objc
    fileprivate func startDateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        self.stepStartDateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc
    fileprivate func endDateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        self.stepEndDateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    func apply(workStep: StepModel, courseWork: CourseWork) {
        self.workStep = workStep
        self.courseWork = courseWork
        
        if isViewLoaded {
            self.showLoadingState()
            
            MoyaServices.worksProvider.request(.getWorkStep(MoyaServices.currentUserId, self.courseWork.id, self.workStep.id)) { (result) in
                switch result {
                case .success(let response):
                    let correctWorkStep = try! response.map(StepModel.self)
                    self.workStep = correctWorkStep
                    
                    self.stepNameTextField.text = self.workStep.title
                    self.stepStartDateTextField.text = DateService.shared.correctStringDate(from: self.workStep.date_start)
                    self.stepEndDateTextField.text = DateService.shared.correctStringDate(from: self.workStep.date_finish)
                    self.stepDescriptionTextView.text = self.workStep.description
                    
                    self.hideEmptyState()
                case .failure(let error):
                    print("GET WORK STEP ERROR")
                }
            }
            
            
        }
    }
   
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureUI()
        self.configureNavigationBar()
        self.configureTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switch self.type {
        case .watch?:
            self.apply(workStep: self.workStep, courseWork: self.courseWork)
            
        case .edit?:
            self.apply(workStep: self.workStep, courseWork: self.courseWork)

        default:
            return
        }
    }
}
