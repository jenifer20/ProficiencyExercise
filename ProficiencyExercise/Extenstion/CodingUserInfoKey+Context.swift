//
//  CodingUserInfoKey+Context.swift
//  ProficiencyExercise
//
//  Created by Jeni on 20/07/20.
//  Copyright © 2020 Jeni. All rights reserved.
//

import Foundation

extension CodingUserInfoKey {
    // Helper property to retrieve the Core Data managed object context
    static let context = CodingUserInfoKey(rawValue: "context")
}
