//
//  FailureResponse.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 21.09.21.
//

enum FailureResponse {
    enum Location {
        case privacyAuthorization
        case geolocationConnection
    }
    enum Internet {
        case connection
    }
    
    case location(_ Location: Location)
    case internet(_ Internet : Internet )
}
