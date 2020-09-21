//
//  ActivityController.swift
//  DetailsMatter
//
//  Created by Tales Conrado on 15/09/20.
//  Copyright © 2020 Tales Conrado. All rights reserved.
//

import UIKit

class ActivityController: UIViewController {

    var selectedRepeat: Int?
    var selectedCategory: Int?
    var selectedStopRepeat: Int?
    var selectedStopRepeatDate: Date?

    lazy var contentView: ActivityView = {
        let view = ActivityView()
        view.delegate = self
        view.selectedOptionRepeat = self.selectedRepeat
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addNavbarItems()
        setDismissKeyboard()
    }

    override func loadView() {
        view = contentView
    }

    func setDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func didTapView() {
        view.endEditing(true)
    }

    func addNavbarItems() {
        title = "Nova Atividade"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                                 target: self,
                                                                                 action: #selector(dismissModal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                                                  target: self,
                                                                                  action: #selector(dismissModal))
        navigationController?.navigationBar.tintColor = .primary
    }

    @objc func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: ActivityDetailsDelegate

extension ActivityController: ActivityDetailsDelegate {
    func showRepeatDetails() {
        let repeatDetailsController = RepeatDetailsController()
        repeatDetailsController.selected = selectedRepeat
        repeatDetailsController.delegate = self
        navigationController?.pushViewController(repeatDetailsController, animated: true)
    }

    func didChangeSelectedRepeatOption(option: Int) {
        selectedRepeat = option
        contentView.selectedOptionRepeat = selectedRepeat
        contentView.frequencyTableView.reloadData()
    }

    func showCategoryDetails() {
        let categoryDetailsController = CategoryDetailsController()
        categoryDetailsController.selected = selectedCategory
        categoryDetailsController.delegate = self
        navigationController?.pushViewController(categoryDetailsController, animated: true)
    }

    func didChangeSelectedCategoryOption(option: Int) {
        selectedCategory = option
        contentView.selectedOptionCategory = selectedCategory
        contentView.frequencyTableView.reloadData()
    }

    func showStopRepeatDetails() {
        let stopRepeatDetailsController = StopRepeatDetailsController()
        stopRepeatDetailsController.selected = selectedStopRepeat
        stopRepeatDetailsController.date = selectedStopRepeatDate
        stopRepeatDetailsController.delegate = self
        if selectedStopRepeatDate != nil {
            stopRepeatDetailsController.contentView.datePickerIndexPath = IndexPath(row: 2, section: 0)
        }
        navigationController?.pushViewController(stopRepeatDetailsController, animated: true)
    }

    func didChangeSelectedStopRepeatOption(option: Int, date: Date?) {
        selectedStopRepeat = option
        selectedStopRepeatDate = date
        contentView.selectedOptionStopRepeat = selectedStopRepeat
        contentView.frequencyTableView.reloadData()
    }
}
