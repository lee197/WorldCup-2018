//
//  TeamDetailViewModelTests.swift
//  WorldCup2018Tests
//
//  Created by 李祺 on 15/04/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import XCTest
@testable import WorldCup2018

class TeamDetailViewModelTests: XCTestCase {
    var sut: TeamDetailViewModel!
    var teamDetailModel: TeamDetailModel!


    override func setUp() {
        teamDetailModel = TeamDetailModel(name: "Russia", flagImageURL: "image_url", groupName: "Group A", isWinner: false, isRunnerup: true)
        sut = TeamDetailViewModel(teamDetailModel: teamDetailModel)
    }

    override func tearDown() {
        sut = nil
        teamDetailModel = nil
    }
    
    func testGetDetailCellModels() {
        let nameIndex = 0
        let rankIndex = 2

        let nameCell = sut.getDetailCellModels(index: nameIndex)
        let rankCell = sut.getDetailCellModels(index: rankIndex)

        
        XCTAssertEqual(nameCell.nameText, "Name: ")
        XCTAssertEqual(nameCell.detailText, teamDetailModel.name)
        
        XCTAssertEqual(rankCell.nameText, "Ranking: ")
        XCTAssertEqual(rankCell.detailText, "2nd")
    }
    
    func testGetTeamFlagUrl() {
        XCTAssertEqual(sut.getTeamFlagUrl(), teamDetailModel.flagImageURL)
    }
    
    func testGetNavTitle() {
        XCTAssertEqual(sut.getNavTitle(), teamDetailModel.name)
    }

    func testGetNumberOfCells() {
        XCTAssertEqual(sut.getNumberOfCells(), 4)
    }
    
    



}
