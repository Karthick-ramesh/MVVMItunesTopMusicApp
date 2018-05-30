//
//  ItunesEndpoint.swift
//  MVVMItunesTopMusicApp
//
//  Created by karthick  Ramesh on 30/05/18.
//  Copyright © 2018 karthick  Ramesh. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum ItunesMusicApi {
    case topMusic(id:Int)
}

extension ItunesMusicApi: EndPointType {
    
    
    
    
    var path: String {
        switch self {
        case .topMusic(let id):
            return "topmusicvideos/limit=\(id)/json"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .topMusic( _):
            return .get
            
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .topMusic( _):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: nil)
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
