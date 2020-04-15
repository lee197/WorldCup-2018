//
//  MockDataSourceService.swift
//  WorldCup2018Tests
//
//  Created by 李祺 on 15/04/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import XCTest

import Foundation
@testable import WorldCup2018

class MockDataSourceService {
    var isFetchDataCalled = false
    var completeTeamData: TeamGroupModel?
    var completeClosure: ((Result<TeamGroupModel, TeamServiceError>) -> Void)!
    
    func fetchSuccess() {
        completeClosure(.success(completeTeamData!))
    }
    
    func fetchFail(error: TeamServiceError) {
        completeClosure(.failure(error))
    }
}

extension MockDataSourceService: DatasourceProtocol {
    
    func getTeamData(complete completionHandler: @escaping (Result<TeamGroupModel, TeamServiceError>) -> ()) {
        isFetchDataCalled = true
        completeClosure = completionHandler
    }
}

class DataGenerator {
    
    var completeTeamData: TeamGroupModel?
    
    func finishFetchTeamData() {
        DatasourceService().getTeamData { [weak self] result in
            self?.completeTeamData = try! result.get()
        }
    }
}
