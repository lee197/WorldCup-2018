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
    case searchError = "No result"
}

class TeamListViewModel {
    private let apiClient: DatasourceProtocol
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var groups: [Group] = []
    var searchedGroup: Group?
    var isSearching = false
    var searchedTeam: Team?

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

        let searchedGroups = groups.filter{$0.sortedTeams.map{$0.name}.contains(searchTerm)}
        if searchedGroups.count != 0 {
            self.searchedGroup = searchedGroups[0]
        }
        
        let searchedTeams = searchedGroup?.teams.filter{$0.name == searchTerm} ?? []
        if searchedTeams.count != 0 {
            self.searchedTeam = searchedTeams[0]
            createCellModels(sortedTeams: [[searchedTeam!]])
        }else {
            alertMessage = UserAlertError.searchError.rawValue
        }
    }
    
    func cancelSearch() {
        isSearching = false
        let sortedTeams = groups.map { $0.sortedTeams }
        createCellModels(sortedTeams: sortedTeams)
    }
    
     func getNumberOfSections() -> Int {
        if isSearching {
            return 1
        }else {
            return groups.count
        }
    }
    
    func getGroupSectionTitles(index:Int) -> String {
        if isSearching {
            return searchedGroup?.name ?? "search result: "

        }else {
            return groups[index].name
        }
    }
    
    func getNumberOfCellsInSection(index:Int) -> Int {
        if isSearching {
            return 1
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
        var teamGroup: Group?
        var team: Team?
        if isSearching {
            teamGroup = searchedGroup
            team = self.searchedTeam
        }else {
            teamGroup = groups[index.section]
            team = teamGroup?.sortedTeams[index.row]
        }
        
        let teamDetailModel = TeamDetailModel(name: team?.name ?? "UNKNOW",
                                              flagImageURL: team?.flag ?? "UNKNOW",
                                              groupName: teamGroup?.name ?? "UNKNOW",
                                              isWinner: teamGroup?.winner == team?.id,
                                              isRunnerup: teamGroup?.runnerup == team?.id )
       return teamDetailModel
    }
}

struct TeamCellViewModel {
    let nameText: String
}



