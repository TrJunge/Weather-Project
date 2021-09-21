//
//  NetworkServices.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(urlString: String, responseOn: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func request<T>(urlString: String, responseOn: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.global().async {
                guard error == nil else {
                    completion(.failure(error!))
                    print("Error URLSession")
                    return
                }
                guard let data = data else { return }
                do {
                    let dataJSON = try JSONDecoder().decode(responseOn, from: data)
                    completion(.success(dataJSON))
                } catch let errorJSON {
                    completion(.failure(errorJSON))
                    print("Error JSON")
                }
            }
        }.resume()
    }
}
