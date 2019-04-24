//
//  NetworkEndPoint.swift
//  TelstraPOC
//
//  Created by Rahul Singh on 22/04/19.
//  Copyright © 2019 Rahul Singh. All rights reserved.
//

import Foundation
import Alamofire

//MARK: EndPointType Protocol
/*
 EndpointType is a protocol which defines all values that we need to form URL request.
 When formed we will pass it to our API manager.
 Because HTTPMethod, HTTPHeaders, and ParameterEncoding are objects from Alamofire library, we need to import it.
 */

protocol EndPointType {
    var baseURL: String { get }
    var path: String { get }
    var url: URL { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var encoding: ParameterEncoding { get }
    var version: String { get }
}

//MARK: NetworkEnVironment
/*
 NetworkEnvironment is another enum object which will define a set of environments on a server side.
 */

enum NetworkEnvironment {
    case dev
    case prod
    case stage
}

//MARK: EndPointItem Enum
/*
 EndpointItem is an enum object which implements EndpointType protocol.
 For each request on a server side, we will add new value to EndpointItem.
 
 */

enum EndPointItem {
    case telstra1
    case telstra2
    case telstra3
}

/*
 We’ve chosen this implementation because it’s easy to use, change, and to add and remove values.
 
 */

extension EndPointItem: EndPointType {
    
    //baseURL

    var baseURL: String {
        switch APIManager.networkEnvironment {
        case .dev: return ""
        case .prod: return ""
        case .stage: return ""
        }
    }
    
    // to get URL STring
    var path: String {
        switch self {
        case .telstra1:
            return Constants.telstraURLString
        default:
            return ""
        }
    }
    
    // For Making Final URL
    var url: URL {
        switch self {
        case .telstra1:
            return URL(string: self.baseURL + self.path)!
        default:
            return URL(string: "")!
        }
    }
    
    // To get Get or Post HttpMethod
    var httpMethod: HTTPMethod {
        switch self {
        case .telstra1:
            return .get
        default:
            return .get
        }
    }
    
    // To set Header
    var headers: HTTPHeaders {
        switch self {
        case .telstra1:
            return ["Content-Type": "application/json",
                    "X-Requested-With": "XMLHttpRequest",
                    "x-access-token": "someToken"]
        default:
            return ["Content-Type": "application/json",
                    "X-Requested-With": "XMLHttpRequest"]
        }

    }
    
    // To get ENcoding
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
    // Version if you want to set
    var version: String {
        return "/V0_1"
    }
    
}
