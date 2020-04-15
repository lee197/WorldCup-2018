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

class TeamViewModel {
    private let apiClient: DatasourceProtocol
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var groups: [Group] = []
    
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
    
     func getNumberOfSections() -> Int {
        return groups.count
    }
    
    func getGroupSectionTitles(index:Int) -> String {
        return groups[index].name
    }
    
    func getNumberOfCellsInSection(index:Int) -> Int {
        return groups[index].sortedTeams.count
    }
    
    func getTeamCellViewModels(at index: IndexPath) -> TeamCellViewModel {
        return teamCellViewModel[index.section][index.row]
    }    
}

extension TeamViewModel {
    
    func userPressedCell(at sectionIndex: Int, and rowIndex: Int) -> TeamDetailModel {
        let teamGroup = groups[sectionIndex]
        let team = teamGroup.sortedTeams[rowIndex]
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



