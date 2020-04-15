//
//  TeamDetailViewModel.swift
//  WorldCup2018
//
//  Created by 李祺 on 15/04/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation

class TeamDetailViewModel {
    private let teamDetailModel: TeamDetailModel
    
    init(teamDetailModel: TeamDetailModel) {
        self.teamDetailModel = teamDetailModel
    }
    
    func getDetailCellModels(index: Int) -> TeamDetailCellViewModel {
        let detailDataArray = getTeamDetailModel()
        return detailDataArray.map { TeamDetailCellViewModel(detailText: $0.value, nameText: $0.key) }[index]
    }

    func getTeamFlagUrl() -> String {
        return teamDetailModel.flagImageURL
    }
    
    func getNavTitle() -> String {
        return teamDetailModel.name
    }
    
    func getNumberOfCells() -> Int {
        return getTeamDetailModel().count + 1
    }
    
    private func getTeamDetailModel() -> [(key: String,value: String)]{
        var teamDetailData: [(String,String)] = []
        var teamRanking = ""
        
        if teamDetailModel.isWinner {
            teamRanking = "1st"
        }else if teamDetailModel.isRunnerup {
            teamRanking = "2nd"
        }else {
            teamRanking = "Lost"
        }
        
        teamDetailData.append((key: "Name: ", value: teamDetailModel.name))
        teamDetailData.append((key: "Group: ", value: teamDetailModel.groupName))
        teamDetailData.append((key: "Ranking: ", value: teamRanking))
        
        return teamDetailData
    }
}

struct TeamDetailCellViewModel {
    let detailText: String
    let nameText: String
}
