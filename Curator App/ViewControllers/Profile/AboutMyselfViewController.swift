//
//  AboutMyselfViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 17/10/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit
import Moya

class AboutMyselfViewController: UIViewController, UITextFieldDelegate {

    // MARK: - InstanvarProperies
    
    @IBOutlet weak var aboutMyselfTextView: UITextView!
    
    // MARK: -
    
    var profileModel: Profile!
    
    // MARK: - Instance Methods
    
    @IBAction func onCancelButtonTouchUpInside(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onDoneButtonTouchUpInside(_ sender: Any) {
        //запрос на сохранение
        
        let provider = MoyaProvider<MoyaProfileService>()
        
        provider.request(.changeProfileInfo(self.profileModel)) { (result) in
            switch result {
            case let .success(moyaResponse):
                print(moyaResponse.statusCode)
                print("CHANGE DESCRIPTION")
            
            default:
                return
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: -
    
    fileprivate func configureDesign() {
        self.navigationItem.title = "О себе"
    }
    
    func apply(profileModel: Profile) {
        self.profileModel = profileModel
        
        if isViewLoaded {
            self.aboutMyselfTextView.text = self.profileModel.description
        }
    }
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.apply(profileModel: self.profileModel)
    }
}

extension AboutMyselfViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        self.profileModel.description =  self.aboutMyselfTextView.text
    }
}
