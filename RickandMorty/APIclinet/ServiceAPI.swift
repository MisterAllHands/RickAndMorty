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
    ///   - type: The type of object we expect to get back
    ///   - request: Request instance
    public func execute<T: Codable>(
        _ request: APIRequest,
        expecting type: T.Type,
        completion: @escaping (Result <T, Error>) -> ()
    ){
        
    }
}


