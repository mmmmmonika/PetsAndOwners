//
//  Pet.swift
//  PetsAndOwners
//
//  Created by Monika Piesyk on 28/10/2022.
//

import Foundation

enum PetType: Int, Codable {
    case dog = 0
    case cat
}

struct Pet: Codable {
    let petType: PetType
    let name: String
    let image: String
}
