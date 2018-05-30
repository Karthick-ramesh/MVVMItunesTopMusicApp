//
//  Artist.swift
//  MVVMItunesTopMusicApp
//
//  Created by karthick  Ramesh on 29/05/18.
//  Copyright © 2018 karthick  Ramesh. All rights reserved.
//

import Foundation

struct CoverArt{
    private(set) var imageUrlString:String?
    
    var imageUrl:URL?{
        get{
            guard let imageUrlString = imageUrlString else{
                return nil
            }
            return URL(string: imageUrlString)
        }
    }
    
    private(set) var height:String
}

extension CoverArt:Decodable{
    enum CoverArtCodingKeys:String,CodingKey{
        case imageUrl = "label"
        case attributes
        case height
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CoverArtCodingKeys.self)
        imageUrlString = try container.decode(String.self, forKey: .imageUrl)
        let attributeContainer = try container.nestedContainer(keyedBy: CoverArtCodingKeys.self, forKey: .attributes)
        height = try attributeContainer.decode(String.self, forKey: .height)
        
    }
}
