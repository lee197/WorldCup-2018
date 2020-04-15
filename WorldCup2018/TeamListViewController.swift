//
//  ViewController.swift
//  WorldCup2018
//
//  Created by 李祺 on 15/04/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import UIKit

class TeamListViewController: UIViewController {
    private lazy var teamViewModel = {
        return TeamViewModel()
    }()
    private weak var tableView: UITableView!
    override func loadView() {
        super.loadView()
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "theme")
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: tableView.topAnchor),
            self.view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            self.view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
        ])
        self.tableView = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        initViewModel()
    }
    
    private func initViewModel() {
        teamViewModel.showAlertClosure = { [weak self] in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.showAlert(alertMessage: self.teamViewModel.alertMessage ?? "UNKOWN ERROR")
            }
        }
        
        teamViewModel.reloadTableViewClosure = { [weak self] in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        teamViewModel.initFetch()
    }
    
    private func showAlert(alertMessage:String) {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(TeamListCell.self, forCellReuseIdentifier: "teamCell")
        tableView.rowHeight = 60
    }
}

extension TeamListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
       return teamViewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamViewModel.getNumberOfCellsInSection(index: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as! TeamListCell
        cell.teamCellViewModel = teamViewModel.getTeamCellViewModels(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return teamViewModel.getGroupSectionTitles(index: section)
    }
}


