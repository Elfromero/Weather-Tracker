//
//  NetworkManager.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/7/24.
//

import Foundation

import Foundation
import Alamofire

actor NetworkManager: GlobalActor {
    static let shared = NetworkManager()
    private init() {}
    
    enum ParameterKey {
        static let apiKey = "key"
    }

    private let weatherAPIBaseURL = "https://api.weatherapi.com/v1"
    private let apiKey = "4ad329128a554c9f83d201156240712"

    func get(path: String, parameters: Parameters?) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            var parameters = parameters ?? [:]
            parameters[ParameterKey.apiKey] = apiKey
            Alamofire.request(
                weatherAPIBaseURL + path,
                parameters: parameters,
                encoding: URLEncoding.queryString
            )
            .responseData { response in
                switch(response.result) {
                case let .success(data):
                    continuation.resume(returning: data)
                case .failure(_):
                    continuation.resume(throwing: NetworkError.connectionIssue)
                }
            }
        }
    }
}

enum NetworkError: Error {
    case connectionIssue
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .connectionIssue:
            return "Unable to connect to the server"
        }
    }
}
