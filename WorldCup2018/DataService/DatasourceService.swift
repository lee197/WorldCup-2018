//
//  DatasourceService.swift
//  WorldCup2018
//
//  Created by 李祺 on 15/04/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation

enum TeamServiceError: String, Error {
    case serverError
    case clentError
}

protocol DatasourceProtocol {
    func  getTeamData(complete completionHandler: @escaping (Result<TeamGroupModel, TeamServiceError>) -> Void)
}

final class DatasourceService: DatasourceProtocol {
    let fileName = "WorldCup2018"
    
    func getTeamData(complete completionHandler: @escaping (Result<TeamGroupModel, TeamServiceError>) -> Void) {
        do {
            let path = Bundle.main.path(forResource: fileName, ofType: "json")!
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let teamSchme = try decoder.decode(TeamGroupModel.self, from: data)
            completionHandler(.success(teamSchme))
        } catch {
            completionHandler(.failure(.serverError))
        }
    }
}
