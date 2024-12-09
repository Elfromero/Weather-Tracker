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
                case let .failure(error):
                    continuation.resume(throwing: self.handleError(error: error))
                }
            }
        }
    }

    private func handleError(error: Error) -> Error {
        if let underlyingError = (error as? AFError)?.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code
            if code == NSURLErrorNotConnectedToInternet ||
                code == NSURLErrorTimedOut ||
                code == NSURLErrorInternationalRoamingOff ||
                code == NSURLErrorDataNotAllowed ||
                code == NSURLErrorCannotFindHost ||
                code == NSURLErrorCannotConnectToHost ||
                code == NSURLErrorNetworkConnectionLost
            {
                var userInfo = nserror.userInfo
                userInfo[NSLocalizedDescriptionKey] = "Unable to connect to the server"
                let currentError = NSError(
                    domain: nserror.domain,
                    code: code,
                    userInfo: userInfo
                )
                return currentError
            }
        }
        return error
    }
}
