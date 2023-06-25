//
//  NetworkService.swift
//  HammerSystemsEntranceTask
//
//  Created by Nikita Marin on 24.06.2023.
//

import Alamofire

final class NetworkService {
    private let baseURL = "https://api.spoonacular.com"
    private let apiKey = "KEY"
    
    private func sendRequest<T: Codable>(
        endpoint: String,
        parameters: Parameters,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        AF.request(
            baseURL + endpoint,
            parameters: parameters,
            headers: HTTPHeaders(["X-API-KEY": apiKey])
        )
        .validate()
        .responseDecodable { (response: DataResponse<T, AFError>) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getRecipes(completion: @escaping (Result<Recipes, Error>) -> Void) {
        sendRequest(
            endpoint: "/recipes/random",
            parameters: ["number": 100],
            completion: completion
        )
    }
}

struct Recipes: Codable {
    let recipes: [Recipe]
}
