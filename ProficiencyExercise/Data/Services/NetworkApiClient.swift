//
//  NetworkApiClient.swift
//  ProficiencyExercise
//
//  Created by Jeni on 19/07/20.
//  Copyright © 2020 Jeni. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ResponseHandler = (ApiResponse) -> Void

class NetworkApiClient {
    
    func callApi<T>(request: ApiRequest<T>, responseHandler: @escaping ResponseHandler) {

        let urlRequest = urlRequestWith(apiRequest: request)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            
            let apiResponse = self.successResponse(request: request, data: data!)
            
            if apiResponse.success {
                responseHandler(apiResponse)
            }
            
            // Check if an error occured
            if error != nil {
                // HERE you can manage the error
                print(error!)
                self.failureResponse(data: data!)
                return
            }
        })
        task.resume()
    }

    func urlRequestWith<T>(apiRequest: ApiRequest<T>) -> URLRequest {
        
        let  completeUrl = apiRequest.webserviceUrl() + apiRequest.apiPath() +
            apiRequest.apiVersion() + apiRequest.apiResource() + apiRequest.endPoint()

        var urlRequest = URLRequest(url: URL(string: completeUrl)!)
        urlRequest.httpMethod = apiRequest.requestType().rawValue
        
        if urlRequest.httpMethod == "POST" {
            urlRequest.setValue(apiRequest.contentType(), forHTTPHeaderField:  "Content-Type")
            urlRequest.httpBody = try?JSONSerialization.data(withJSONObject:  apiRequest.bodyParams()!, options: [])
        }
        return urlRequest
    }
    
    // here we are going to parse the data
    func successResponse<T: Codable>(request: ApiRequest<T>,
                                     data: Data) -> ApiResponse{
        do {
            //                let responseJson = try JSON(data: response)
            if
                let response = String(data: data, encoding: String.Encoding.ascii),
                let data = response.data(using: String.Encoding.utf8)
            {
                let responseJson = try JSON(data: data)
                print(responseJson)
                
                let dataJson = responseJson["rows"].object
                
                let newData = try JSONSerialization.data(withJSONObject: dataJson as Any,
                                                      options: [])
                
                let dataController = DataController()

                if dataController.parse(newData) {
                    print("Success Parsing")
                }else {
                    print("Failure Parsing")
                }
                
                return ApiResponse(success: true, title: responseJson["title"].string!)
            }
            return ApiResponse(success: false)
            
        } catch {
            return ApiResponse(success: false)
        }
    }
    
    func failureResponse(data: Data) {
        // do something here
    }
}
