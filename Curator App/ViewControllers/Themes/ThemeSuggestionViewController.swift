//
//  ThemeSuggestionViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 06/11/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class ThemeSuggestionViewController: UIViewController {
    
    // MARK: - Nested Types
    
    fileprivate enum Constants {
        
        // MARK: - Instance Properties
        
        static let commentCellIdenifier = "suggestionThemeCommentCellIdentifier"
    }
    
    // MARK: - Instance Properties

    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Instance Methods
    
    fileprivate func config(cell: SuggestionThemeCommentTableViewCell, for indexPath: IndexPath) {
        cell.commentAuthorNameLabel.text = "Тест Автор"
        cell.commentAuthorTextLabel.text = "Тест комментарий"
    }
    
    private func configureNavigationBar() {
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(onEditButtonTouchUpInside))
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    @objc
    private func onEditButtonTouchUpInside() {
        let editThemeVC = UIStoryboard.init(name: "Themes", bundle: nil).instantiateViewController(withIdentifier: "editThemeVC") as! EditThemeViewController
        self.navigationController?.pushViewController(editThemeVC, animated: true)
    }
    
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        // Do any additional setup after loading the view.
    }
}

// MARK: - UITableViewDataSource

extension ThemeSuggestionViewController: UITableViewDataSource {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.commentCellIdenifier, for: indexPath)
        
        self.config(cell: cell as! SuggestionThemeCommentTableViewCell, for: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ThemeSuggestionViewController: UITableViewDelegate {
    
    // MARK: - Instance Methods
    
}
