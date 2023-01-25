//
//  NetworkServices.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(latitude: String, longitude: String, responseOn: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    private static let units = "metric"
    private static let keyAPI = "603cbab18b03ffb19439cac48a49168e"
    private let mainUrlString = "https://api.openweathermap.org/data/2.5/forecast?units=\(units)&appid=\(keyAPI)"
    
    func request<T: Decodable>(latitude: String, longitude: String, responseOn: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let urlString = mainUrlString + "lat=\(latitude)&lon=\(longitude)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.global().async {
                if let error = error { return completion(.failure(error)) }
                guard let data = data else { return }
                do {
                    let dataJSON = try JSONDecoder().decode(responseOn, from: data)
                    completion(.success(dataJSON))
                } catch let errorJSON {
                    completion(.failure(errorJSON))
                }
            }
        }.resume()
    }
}
