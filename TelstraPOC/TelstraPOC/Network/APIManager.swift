//
//  APIManager.swift
//  TelstraPOC
//
//  Created by Rahul Singh on 22/04/19.
//  Copyright © 2019 Rahul Singh. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {

    //API manager will have static variable network environment which we use to form URL in EndointItemObject.

    static let networkEnvironment: NetworkEnvironment = .dev
    
    
    /*
     We are using generic argument T where T is Codable. T will inform APIManager about what kind of data we are fetching and what kind of object we want the manager to return. T can be any object or, an array of objects, which implements Decodable and Encodable protocols. After setting T, if needed, we can add request parameters.
     
     If the request is successful, we’ll get a predefined object. If not we will initialize the error object and display it using AlertMessage.
     */

    func fetchData<T>(type: EndPointType, parameters: Parameters? = nil, handler: @escaping (T?,_ error: AlertMessage?)-> ()) where T: Codable {
        
        // Alamofire Request
        Alamofire.request(type.url,
        method: type.httpMethod,
        parameters: parameters,
        encoding: type.encoding,
        headers: type.headers).validate().responseData { data in
            // Data Reult Success or Failure
            switch data.result {
                
            // If Success
            case .success:
                // Change Data in Readable format 1. In String 2. Again in Data
                let decoder = JSONDecoder()
                if let responseData = data.result.value {
                    let dataString = String(data: responseData, encoding: String.Encoding.isoLatin1)
                    guard let modifiedData = dataString?.data(using: String.Encoding.utf8) else {
                        return
                    }
                    // Finally in Result using Generic Model T
                    let result = try? decoder.decode(T.self, from: modifiedData)
                    // assign result to call Back
                    handler(result, nil)
                }
                break
                // If Failure
            case .failure(let error as NSError):
                // Assign Error to call back
                handler(nil, self.parsedAPIError(data: data.data, errorObj: error as NSError))
                break
            }
         
        }
}

// For Parsing Error According to the requiment and returning finally as an Alert Message object
    func parsedAPIError(data: Data?, errorObj: NSError?) -> AlertMessage {
        let decoder  = JSONDecoder()
        
        if let jsonData = data, let error = try? decoder.decode(ErrorObject.self, from: jsonData) {
            return AlertMessage(title: Constants.errorAlertTitle, body: error.key ?? error.message)
        }
        
        if let error = errorObj {
            return AlertMessage(title: Constants.errorAlertTitle, body: error.localizedDescription)
        }
        
        return AlertMessage(title: Constants.errorAlertTitle, body: Constants.generalErrorMessage)
    }
}

