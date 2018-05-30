//
//  MusicItem.swift
//  MVVMItunesTopMusicApp
//
//  Created by karthick  Ramesh on 29/05/18.
//  Copyright © 2018 karthick  Ramesh. All rights reserved.
//

import Foundation

struct TopMusicApiResponse{
    private(set) var musicItems:[MusicItem]
}

extension TopMusicApiResponse:Decodable{
    private enum TopMusicApiResponseCodingKeys: String, CodingKey {
        case musicItems = "entry"
        case response = "feed"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TopMusicApiResponseCodingKeys.self)
        let response = try container.nestedContainer(keyedBy: TopMusicApiResponseCodingKeys.self, forKey: .response)
        musicItems = try response.decode([MusicItem].self, forKey: .musicItems)
        
    }
}

struct MusicItem{
    private(set) var name:String?
    private(set) var title:String
    private(set) var albumCoverImage:[CoverArt]
}

extension MusicItem:Decodable{
    private enum TopMusicItemsCodingKeys: String, CodingKey {
        case name = "im:name"
        case innerLabel = "label"
        case title = "title"
        case albumCover = "im:image"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TopMusicItemsCodingKeys.self)
        
        let nameContainer = try container.nestedContainer(keyedBy: TopMusicItemsCodingKeys.self, forKey: .name)
        name = try nameContainer.decode(String.self, forKey:.innerLabel)
        
        let titleContainer = try container.nestedContainer(keyedBy: TopMusicItemsCodingKeys.self, forKey: .title)
        title = try titleContainer.decode(String.self, forKey:.innerLabel)
        albumCoverImage = try container.decode([CoverArt].self, forKey: .albumCover)
    }
}

