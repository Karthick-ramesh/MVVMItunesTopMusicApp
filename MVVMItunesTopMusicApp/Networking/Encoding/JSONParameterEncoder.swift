//
//  JSONParameterEncoder.swift
//  MVVMItunesTopMusicApp
//
//  Created by karthick  Ramesh on 30/05/18.
//  Copyright © 2018 karthick  Ramesh. All rights reserved.
//

import Foundation


public struct JSONParameterEncoder: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }catch {
            throw NetworkError.encodingFailed
        }
    }
}

