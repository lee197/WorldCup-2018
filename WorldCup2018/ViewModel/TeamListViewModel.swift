//
//  TeamViewModel.swift
//  WorldCup2018
//
//  Created by 李祺 on 15/04/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation

enum UserAlertError:  String, Error {
    case userError = "Please make sure your network is working fine or re-launch the app"
    case serverError = "Please wait a while and re-launch the app"
}

class TeamListViewModel {
    private let apiClient: DatasourceProtocol
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var groups: [Group] = []
    var searchedGroups: [Group] = []
    var isSearching = false
    var searchedTeam: [[Team]]?

    var alertMessage: String? {
        didSet {
            showAlertClosure?()
        }
    }
    private var teamCellViewModel: [[TeamCellViewModel]] = [] {
        didSet {
            reloadTableViewClosure?()
        }
    }
    
    
    init(apiClient: DatasourceProtocol = DatasourceService()) {
        self.apiClient = apiClient
    }
    
    func initFetch() {
        apiClient.getTeamData { [weak self] result in
            guard let self = self else {
                return
            }
            
            do {
                let teamData = try result.get()
                self.processTeamData(teamData: teamData)
            } catch {
                self.alertMessage = UserAlertError.serverError.rawValue
            }
        }
    }
    
    func getSearchTeam(searchTerm: String) {
        isSearching = true

        searchedGroups = groups.filter{$0.sortedTeams.map{$0.name}.contains(searchTerm)}
        searchedTeam = groups.map{$0.sortedTeams.filter{$0.name == searchTerm}}.filter{$0.count != 0}
        createCellModels(sortedTeams: searchedTeam!)
    }
    
    func cancelSearch() {
        isSearching = false
        let sortedTeams = groups.map { $0.sortedTeams }
        createCellModels(sortedTeams: sortedTeams)
    }
    
     func getNumberOfSections() -> Int {
        if isSearching {
            return searchedGroups.count
        }else {
            return groups.count
        }
    }
    
    func getGroupSectionTitles(index:Int) -> String {
        if isSearching {
            return searchedGroups[index].name

        }else {
            return groups[index].name
        }
    }
    
    func getNumberOfCellsInSection(index:Int) -> Int {
        if isSearching {
            return searchedTeam?.count ?? 0
        }else {
            return groups[index].sortedTeams.count
        }
    }
    
    func getTeamCellViewModels(at index: IndexPath) -> TeamCellViewModel {
        return teamCellViewModel[index.section][index.row]
    }
    
    private func processTeamData(teamData:TeamGroupModel){
        groups.append(teamData.groups.a)
        groups.append(teamData.groups.b)
        groups.append(teamData.groups.c)
        groups.append(teamData.groups.d)
        groups.append(teamData.groups.e)
        groups.append(teamData.groups.f)
        groups.append(teamData.groups.g)
        
        let sortedTeams = groups.map { $0.sortedTeams }
        createCellModels(sortedTeams: sortedTeams)
    }
    
    private func createCellModels(sortedTeams:[[Team]]) {
        teamCellViewModel =  sortedTeams.map { $0.map{ TeamCellViewModel(nameText: $0.name) } }
     }
}

extension TeamListViewModel {
    
    func userPressedCell(at index: IndexPath) -> TeamDetailModel {
        let teamGroup = groups[index.section]
        let team = teamGroup.sortedTeams[index.row]
        let teamDetailModel = TeamDetailModel(name: team.name,
                                              flagImageURL: team.flag,
                                              groupName: teamGroup.name,
                                              isWinner: teamGroup.winner == team.id,
                                              isRunnerup: teamGroup.runnerup == team.id)
       return teamDetailModel
    }
}

struct TeamCellViewModel {
    let nameText: String
}



