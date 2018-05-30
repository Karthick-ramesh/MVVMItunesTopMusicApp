//
//  TopMusicViewModel.swift
//  MVVMItunesTopMusicApp
//
//  Created by karthick  Ramesh on 28/05/18.
//  Copyright © 2018 karthick  Ramesh. All rights reserved.
//

import Foundation

protocol TopMusicItemPresentable{
    var musicName:String?{get}
    var musicTitle:String?{get}
    var coverArtImageUrl:URL?{get}
    
}

class TopMusicItemViewModel: TopMusicItemPresentable {
    var musicName: String?
    
    var musicTitle: String?
    
    var coverArtImageUrl: URL? {
        get{
            return albumCoverArt?.imageUrl
        }
    }
    
    private var albumCoverArt: CoverArt?
    
    init(name:String?,title:String?,coverArt:CoverArt?) {
        musicName = name
        musicTitle = title
        albumCoverArt = coverArt
    }
    
    
}

protocol TopMusicProtocol{
    
    var topMusicItems:[TopMusicItemPresentable]?    {get}
    func getTopMusic(page: Int, completion: @escaping (_ movie: [TopMusicItemPresentable]?,_ error: String?)->())
    
}


class TopMusicViewModel:TopMusicProtocol,NetworkManager{
    
    private var topMusicResponse:TopMusicApiResponse?
    var topMusicItems: [TopMusicItemPresentable]? = nil
    private var router = Router<ItunesMusicApi>()
    
    func getTopMusic(page: Int, completion: @escaping (_ movie: [TopMusicItemPresentable]?,_ error: String?)->()){
        
        router.request(.topMusic(id: page)) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        self.topMusicResponse = try JSONDecoder().decode(TopMusicApiResponse.self, from: responseData)
                        
                        self.topMusicItems = self.topMusicResponse?.musicItems.map(){data in
                            TopMusicItemViewModel(name: data.name, title: data.title, coverArt: data.albumCoverImage[0])
                        };
                        completion(self.topMusicItems,nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
}
