//
//  ServiceError.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 1/2/24.
//

import Foundation

import Moya

enum ServiceError: Error {
    case moyaError(MoyaError)
    case invalidResponse(responseCode: Int, message: String)
    case decodingError
    case tokenExpired
    case refreshTokenExpired
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .moyaError(let moyaError):
            return "❗️" + moyaError.localizedDescription + "❗️"
        case .invalidResponse(_, let message):
            return "❗️" + message + "❗️"
        case .tokenExpired:
            return "❗️Access Token Expired❗️"
        case .refreshTokenExpired:
            return "❗️Refresh Token Expired❗️"
        case .decodingError:
            return "❗️Decoding Error Occured❗️"
        }
    }
}
