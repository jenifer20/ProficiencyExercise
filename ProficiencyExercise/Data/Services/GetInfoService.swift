//
//  GetInfoService.swift
//  ProficiencyExercise
//
//  Created by Jeni on 19/07/20.
//  Copyright © 2020 Jeni. All rights reserved.
//

import Foundation

typealias CompletionHandler =  (Bool, String, AnyObject?) -> Void

class GetInfoService {
    
    func getInfoApi(completion: @escaping CompletionHandler) {
        let request = GetInfoRequest()
        NetworkApiClient().callApi(request: request) { (apiResponse) in
            if apiResponse.success {
                completion(true, apiResponse.title ?? "", apiResponse.rows)
            } else {
                completion(false, apiResponse.title ?? "", apiResponse.rows)
            }
        }
    }
}
