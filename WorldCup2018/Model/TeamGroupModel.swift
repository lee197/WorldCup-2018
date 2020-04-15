//
//  TeamModel.swift
//  WorldCup2018
//
//  Created by 李祺 on 15/04/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation

struct TeamGroupModel: Codable {
    let groups: Groups
}

struct Groups: Codable {
    let a, b, c, d, e, f, g: Group
}

struct Group: Codable {
    let name: String
    let winner, runnerup: Int
    private let teams: [Team]
    var sortedTeams: [Team] { return teams.sorted{ $0.name < $1.name }}
}

struct Team: Codable {
    let id: Int
    let name, fifaCode, iso2, flag: String
    let emoji, emojiString: String

}
