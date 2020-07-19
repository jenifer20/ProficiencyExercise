//
//  ApiRequest.swift
//  ProficiencyExercise
//
//  Created by Jeni on 19/07/20.
//  Copyright © 2020 Jeni. All rights reserved.
//

import Foundation

class ApiRequest<T: Codable> {

    func webserviceUrl() -> String {
        return ""
    }

    func apiPath() -> String {
        return ""
    }

    func apiVersion() -> String {
        return ""
    }

    func apiResource() -> String {
        return ""
    }

    func endPoint() -> String {
        return ""
    }

    func bodyParams() -> NSDictionary? {
        return [:]
    }

    func requestType() -> HTTPMethod {
        return .get
    }

    func contentType() -> String {
        return "application/json"
    }
}
