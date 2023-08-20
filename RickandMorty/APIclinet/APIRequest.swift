//
//  APIRequest.swift
//  RickandMorty
//
//  Created by TTGMOTSF on 17/08/2023.
//

import Foundation


///Object that represents single API Call
final class APIRequest {

    ///API Constants
    private struct Const {
        static let baseURL = "https://rickandmortyapi.com/api"
    }
    
    ///Endpoint
    private let endPoint: Endpoint
    
    ///These are path components if any
    private let pathComponents: [String]
    
    ///Queery components for API, if any
    private let queery: [URLQueryItem]
    
    ///Constracted URL for the api request in string format
    private var urlString: String {
        var string = Const.baseURL
        string += "/"
        string += endPoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({string += "/\($0)"})
        }
        
        if !queery.isEmpty{
            string += "?"
            let argumentString = queery.compactMap({
                guard let value = $0.value else {return nil}
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        return string
    }
    
    //MARK: - Public
    
    ///Desired HTTP method
    public let httpMethod = "GET"
    
   
    ///Computed constructed API
    public var url: URL? {
        URL(string: urlString)
    }

    
    //Construct Request
    ///- Parameters:
    ///- endPoint: Collection of endPoint components
    ///- pathComponents: Collection of path components
    ///- queery:  Collection of queery parameters
    init(
        endPoint: Endpoint,
        pathComponents: [String] = [],
        queery: [URLQueryItem] = []
    ) {
        self.endPoint = endPoint
        self.pathComponents = pathComponents
        self.queery = queery
    }
}

extension APIRequest {
    static let listCharacterRequests = APIRequest(endPoint: .character)
}
extension APIRequest {
    static let listEpisodeRequests = APIRequest(endPoint: .episode)
}
