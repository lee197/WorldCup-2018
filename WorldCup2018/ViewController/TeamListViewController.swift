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
        return TeamListViewModel()
    }()
    private weak var tableView: UITableView!
    override func loadView() {
        super.loadView()
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "theme")
        self.view.backgroundColor = UIColor(named: "theme")
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            self.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: tableView.topAnchor, constant: -60),
            self.view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            self.view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            self.view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
        ])
        tableView.backgroundColor = UIColor(named: "theme")
        self.tableView = tableView
    }
    
    lazy var searchBar:UISearchBar = UISearchBar()
    var searchActive : Bool = false
    var filtered:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        initViewModel()
        self.navigationItem.title = "World Cup 2018"
        setUpSearchBar()
    }
    
    private func setUpSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 60))
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        searchBar.tintColor = .white
        searchBar.barTintColor = UIColor(named: "theme")
        searchBar.searchTextField.textColor = .white
        searchBar.showsCancelButton = true
        
        self.view.addSubview(searchBar)
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
        tableView.delegate = self
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 40))
        let titleLabel = UILabel(frame: CGRect(x: 20, y: 5, width: self.tableView.frame.width, height: 20))
        titleLabel.text = teamViewModel.getGroupSectionTitles(index: section)
        titleLabel.textColor = .white
        headerView.addSubview(titleLabel)
        headerView.backgroundColor = UIColor(named: "nav")
        return headerView
    }
}

extension TeamListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedTeam = teamViewModel.userPressedCell(at: indexPath)
        let vc = TeamDetailViewController(teamDetailViewModel: TeamDetailViewModel(teamDetailModel: selectedTeam))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension TeamListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let shipName = searchBar.text else { return }
        teamViewModel.getSearchTeam(searchTerm: shipName)
    }
        
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        teamViewModel.cancelSearch()
    }
}

