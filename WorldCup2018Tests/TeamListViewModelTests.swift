//
//  WorldCup2018Tests.swift
//  WorldCup2018Tests
//
//  Created by 李祺 on 15/04/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import XCTest
@testable import WorldCup2018

class TeamListViewModelTests: XCTestCase {
    
    var sut: TeamListViewModel!
    var mockService: MockDataSourceService!
    
    override func setUp() {
        mockService = MockDataSourceService()
        sut = TeamListViewModel(apiClient: mockService)
    }
    
    override func tearDown() {
        mockService = nil
        sut = nil
    }
    
    func testIfFetchCalled() {
        sut.initFetch()
        
        XCTAssert(mockService.isFetchDataCalled)
    }
    
    func testIfTeamDataFetched() {
        fetchFinished()
        XCTAssertEqual(mockService.completeTeamData?.groups.a.name, "Group A")
    }
    
    func testFetchCalledFailed() {
        let serviceError = TeamServiceError.serverError
        let userAlertError = UserAlertError.serverError
        
        sut.initFetch()
        mockService.fetchFail(error: serviceError)
        
        XCTAssertEqual(sut.alertMessage, userAlertError.rawValue)
    }
    
    func testGetNumberOfSections(){
        fetchFinished()
        let numberOfSections = sut.getNumberOfSections()
        
        XCTAssertEqual(numberOfSections,sut.groups.count)
    }
    
    func testGetGroupSectionTitles(){
        fetchFinished()
        let firstSection = 0
        let sectionTitle = sut.getGroupSectionTitles(index: firstSection)
        
        XCTAssertEqual(sectionTitle,sut.groups[firstSection].name)
    }
    
    func testGetNumberOfCellsInSection(){
        fetchFinished()
        let firstSection = 0
        let teamsInFirstSection = sut.getNumberOfCellsInSection(index: firstSection)
        
        XCTAssertEqual(teamsInFirstSection,sut.groups[firstSection].sortedTeams.count)
    }
    
    func testGetTeamCellViewModels(){
        fetchFinished()
        let firstRowInFirstSection = IndexPath(row: 0, section: 0)
        let teamCellModel = sut.getTeamCellViewModels(at: firstRowInFirstSection)
        let sortedTeam = sut.groups[firstRowInFirstSection.section].sortedTeams
         
        
        XCTAssertEqual(teamCellModel.nameText,sortedTeam[firstRowInFirstSection.row].name)
    }
    
    func testUserPressCell(){
        fetchFinished()
        let secondRowInFirstSection = IndexPath(row: 1, section: 0)
        let teamDetail = sut.userPressedCell(at: secondRowInFirstSection)
        
        XCTAssertEqual(teamDetail.name,
                       sut.groups[secondRowInFirstSection.section].sortedTeams[secondRowInFirstSection.row].name)
        XCTAssertTrue(teamDetail.isRunnerup)
    }
    
    func 
}

extension TeamListViewModelTests {
    private func fetchFinished() {
        let teamData = DataGenerator()
        teamData.finishFetchTeamData()
        mockService.completeTeamData = teamData.completeTeamData!
        sut.initFetch()
        mockService.fetchSuccess()
    }
}
