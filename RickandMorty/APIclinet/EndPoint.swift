//
//  EndPoint.swift
//  RickandMorty
//
//  Created by TTGMOTSF on 17/08/2023.
//

import Foundation



///Object that represents uinque API endpoint
@frozen enum Endpoint: String {
    ///Endpoint to get character info
    case character
    ///Endpoint to get location info
    case location
    ///Endpoint to get episode info
    case episode
}
