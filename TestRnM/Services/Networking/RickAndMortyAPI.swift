//
//  RickAndMortyAPI.swift
//  TestRnM
//
//  Created by Anderen on 04.04.2025.
//

import Foundation
import Moya

enum RickAndMortyAPI {
    case characters(page: Int)
}

extension RickAndMortyAPI: TargetType {

    var baseURL: URL {
        return URL(string: "https://rickandmortyapi.com/api")!
    }

    var path: String {
        switch self {
        case .characters:
            return "/character"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case let .characters(page):
            return .requestParameters(
                parameters: ["page": page],
                encoding: URLEncoding.queryString
            )
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

}
