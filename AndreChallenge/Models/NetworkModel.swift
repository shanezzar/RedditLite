//
//  NetworkModel.swift
//  AndreChallenge
//
//  Created by Shanezzar Sharon on 24/11/2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkModel: ObservableObject {
    
    // MARK:- variables
    static var shared = NetworkModel()
    
    @Published var reddits: [Reddit] = [Reddit]()
    @Published var isLoading: Bool = false
    @Published var error: String = ""
    
    func fetchData(topic: String) {
        guard !isLoading else { return }
        isLoading = true
        
        let url = "https://www.reddit.com/r/\(topic.isEmpty ? "fitness" : topic)/.json"
        
        AF.request(url).response { response in
            switch response.result {
            case .success(let data):
                self.isLoading = false
                self.reddits.removeAll()
                self.error = ""
                
                guard let responseData = data else { return }
                guard let json = try? JSON(data: responseData) else { return }
                
                guard let dataDict = json["data"].dictionary else { return }
                guard let childrenArray = dataDict["children"]?.array else { return }
                
                self.reddits = childrenArray.map({ reddit -> Reddit in
                    let redditData = reddit["data"].dictionary ?? [:]
                    let title = redditData["title"]?.string ?? ""
                    let selfText = redditData["selftext"]?.string ?? ""
                    let url = redditData["url"]?.string ?? ""
                    let ups = redditData["ups"]?.int ?? 0
                    let downs = redditData["downs"]?.int ?? 0
                    
                    return Reddit(title: title, selfText: selfText, url: url, ups: ups, downs: downs)
                })
                break
            case .failure(let error):
                self.isLoading = false
                self.reddits.removeAll()
                self.error = error.localizedDescription
                break
            }
        }
    }

}
