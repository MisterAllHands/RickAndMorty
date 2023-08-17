//
//  ServiceAPI.swift
//  RickandMorty
//
//  Created by TTGMOTSF on 17/08/2023.
//

import Foundation

///Primary API service object to get Rick and Morty data
final class ServiceAPI {
    ///Shared Singleton instance
    static let shared = ServiceAPI()
    
    ///Privotized constructor
    private init(){}
    
    ///Send Rick and Morty API Call
    /// - Parameters:
    ///   - completion: Callback with data error
    ///   - request: Request instance
    public func execute(_ request: APIRequest, completion: @escaping () -> ()){
        
    }
}


