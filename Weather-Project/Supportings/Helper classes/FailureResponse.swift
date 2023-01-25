//
//  FailureResponse.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 21.09.21.
//

enum FailureResponse: Error {
    enum Location {
        case privacyAuthorization(message: String)
        case geolocationConnection(message: String)
    }
    enum Internet {
        case unknown(message: String)
        case connection(message: String)
        case data(message: String)
    }
    
    case location(_ Location: Location)
    case internet(_ Internet : Internet )
}
