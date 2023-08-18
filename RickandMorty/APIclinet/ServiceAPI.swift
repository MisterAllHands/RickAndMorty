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
    
    enum ServiceAPIError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
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
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(ServiceAPIError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest){ data, _ , error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ServiceAPIError.failedToGetData))
                return
            }
            
            //Decode Response
            
            do{
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }catch{
                print("YOOOOOO, error: \(error)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    //MARK: - Private
    
    private func request(from apiRequest: APIRequest) -> URLRequest? {
        guard let url = apiRequest.url else {return nil}
        var request = URLRequest(url: url)
        request.httpMethod = apiRequest.httpMethod
        return request
    }
}


