//
//  ApiResponse.swift
//  ProficiencyExercise
//
//  Created by Jeni on 19/07/20.
//  Copyright © 2020 Jeni. All rights reserved.
//

import Foundation

class ApiResponse {
    var success: Bool!   // whether the API call passed or failed
    var title: String? // title returned from the API
    var rows: AnyObject? // actual data returned from the API

    init(success: Bool, title: String? = nil, data: AnyObject? = nil) {
        self.success = success
        self.title = title
        self.rows = data
    }
}
