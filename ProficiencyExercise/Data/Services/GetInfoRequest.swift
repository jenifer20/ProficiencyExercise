//
//  GetInfoRequest.swift
//  ProficiencyExercise
//
//  Created by Jeni on 19/07/20.
//  Copyright © 2020 Jeni. All rights reserved.
//

import Foundation

class GetInfoRequest: ApiRequest<[GetInfoResponse]> {
    
    override func webserviceUrl() -> String {
        return AppConstants.API.apiUrl
    }
    
    override func apiPath() -> String {
        return ""
    }
    
    override func endPoint() -> String {
        return ""
    }
    
    override func requestType() -> HTTPMethod {
        return .get
    }
}


