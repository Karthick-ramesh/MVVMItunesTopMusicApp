//
//  EndPointType.swift
//  MVVMItunesTopMusicApp
//
//  Created by karthick  Ramesh on 30/05/18.
//  Copyright © 2018 karthick  Ramesh. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

extension EndPointType{
    
    var environmentBaseURL : String {
        switch AppDelegate.networkEnvironment{
        case .production: return "https://itunes.apple.com/us/rss/"
        case .qa: return "https://itunes.apple.com/us/rss/"
        case .staging: return "https://itunes.apple.com/us/rss/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
}
