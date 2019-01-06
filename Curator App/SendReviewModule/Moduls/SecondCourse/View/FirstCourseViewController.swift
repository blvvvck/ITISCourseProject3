//
//  FirstCourseViewController.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit
import BetterSegmentedControl

class FirstCourseViewController: UIViewController, CourseViewInput {    
    
    var dataSource: StudentsDataSource!
    var presenter: CourseViewOutput!
    let studentCellNibIdentifier = "StudentReviewTableViewCell"
    let studentCellIdentifier = "studentCell"
    let estimatedRowHeight: CGFloat = 100
    var studentCourse: String = "2"
    var tableView = UITableView()
    var studentDbManager: StudentDbManager = StudentDbManager()
    var control = BetterSegmentedControl()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewIsReady(with: studentCourse)
        self.tableView.addSubview(self.refreshControl)
    
        control = BetterSegmentedControl(
            frame: CGRect(x: 0.0, y: 64.0, width: view.bounds.width, height: 35.0),
            titles: ["1 курс", "2 курс", "3 курс"],
            index: 0,
            options: [.backgroundColor(UIColor(red:255, green:255, blue:255, alpha:1.00)),
                      .titleColor(.black),
                      .indicatorViewBackgroundColor(UIColor(red:0.55, green:0.26, blue:0.86, alpha:1.00)),
                      .selectedTitleColor(.white),
                      .titleFont(UIFont(name: "HelveticaNeue", size: 14.0)!),
                      .selectedTitleFont(UIFont(name: "HelveticaNeue-Medium", size: 14.0)!)]
        )
        control.addTarget(self, action: #selector(self.navigationSegmentedControlValueChanged(_:)), for: .valueChanged)
        view.addSubview(control)
        
        
        var students = studentDbManager.getDataFromDB()
        for student in students {
            print(String(describing: student))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        anitmateTable()

    }
    
    @objc func navigationSegmentedControlValueChanged(_ sender: BetterSegmentedControl) {
        if sender.index == 0 {
            dataSource.clearTable()
            presenter.viewIsReady(with: "2")
            tableView.reloadData()
            if tableView.visibleCells.count != 0 {
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
            }
            //reloadTableView()
        }
        if sender.index == 1 {
            dataSource.clearTable()
            presenter.viewIsReady(with: "3")
            tableView.reloadData()
            if tableView.visibleCells.count != 0 {
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
            }
           // self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
            //reloadTableView()


        }
        if sender.index == 2 {
            dataSource.clearTable()
            presenter.viewIsReady(with: "4")
            tableView.reloadData()
            if tableView.visibleCells.count != 0 {
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
            }
          //  self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)

           // reloadTableView()


        }
    }
    
    func prepareTableView() {
        tableView.frame = CGRect(x: 0, y: 100, width: 320, height: 465)
        self.view.addSubview(tableView)
        registerCell()
        tableView.estimatedRowHeight = estimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
    
    func reloadTableView() {
        let previousContentHeight = tableView.contentSize.height
        let previousContentOffset = tableView.contentOffset.y
        tableView.reloadData()
        tableView.layoutIfNeeded()
        let currentContentOffset = tableView.contentSize.height - previousContentHeight + previousContentOffset
        tableView.contentOffset = CGPoint(x: 0, y: currentContentOffset)
        //tableView.reloadData()
    }
    
    func set(cellModels: [CellModel]?) {
        guard let checkedCellModels = cellModels else { return }
        dataSource.clearTable()
        dataSource.setCellModels(with: checkedCellModels)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let moduleHolder = segue.destination as? ModuleInputHolder else { return }
        moduleHolder.moduleInput?.setData(sender)
        let detailVC = segue.destination as? DetailReviewViewController
        detailVC?.id = sender as! Int
    }
    
    private func registerCell() {
        let mediaCellNib = UINib(nibName: studentCellNibIdentifier, bundle: nil)
        self.tableView.register(mediaCellNib, forCellReuseIdentifier: studentCellIdentifier)
    }
    
    func anitmateTable() {
        tableView.reloadData()
        let cells = tableView.visibleCells
        let tableViewHeight = tableView.bounds.size.height
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        var delayCounter = 0
        
        for cell in cells {
            UIView.animate(withDuration: 0.5, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        presenter.viewIsReady(with: String(control.index + 2))
        print("Refreshing")
        refreshControl.endRefreshing()
    }
}

extension FirstCourseViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectStudent(with: dataSource.cellModels[indexPath.row].id) 
    }
}
