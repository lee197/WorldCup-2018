//
//  TeamDetailViewController.swift
//  WorldCup2018
//
//  Created by 李祺 on 15/04/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import UIKit

class TeamDetailViewController: UIViewController {
    private let teamDetailViewModel: TeamDetailViewModel
    private var teamDetailView: UITableView!
    
    init(teamDetailViewModel: TeamDetailViewModel) {
        self.teamDetailViewModel = teamDetailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor(named: "theme")
        self.teamDetailView = createTeamDetailView()
    }
    
    override func viewDidLoad() {
        setTeamDetailView()
        self.navigationItem.title = teamDetailViewModel.getNavTitle()
    }
    
    func setTeamDetailView() {
        teamDetailView.dataSource = self
        teamDetailView.register(TeamFlagImageCell.self, forCellReuseIdentifier: "imageCell")
        teamDetailView.register(TeamDetailCell.self, forCellReuseIdentifier: "detailCell")
        teamDetailView.rowHeight = UITableView.automaticDimension
        teamDetailView.estimatedRowHeight = 600
        teamDetailView.separatorStyle = UITableViewCell.SeparatorStyle.none
        teamDetailView.allowsSelection = false
    }
    
    private func createTeamDetailView() -> UITableView {
        let detailView = UITableView(frame: UIScreen.main.bounds)
        self.view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.backgroundColor = UIColor(named: "theme")
        NSLayoutConstraint.activate([
               self.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: detailView.topAnchor, constant: -10),
               self.view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: detailView.bottomAnchor),
               self.view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: detailView.leadingAnchor),
               self.view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: detailView.trailingAnchor),
           ])
        return detailView
    }
}

extension TeamDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamDetailViewModel.getNumberOfCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! TeamFlagImageCell
            cell.flageImageView.downloaded(from: teamDetailViewModel.getTeamFlagUrl(), contentMode: .scaleAspectFit)
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! TeamDetailCell
            cell.teamDetailCellViewModel = teamDetailViewModel.getDetailCellModels(index:indexPath.row - 1)
            return cell
        }
    }
}
