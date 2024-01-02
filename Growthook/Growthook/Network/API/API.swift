//
//  API.swift
//  Growthook
//
//  Created by KJ on 11/4/23.
//

import Foundation

import Moya
import RxCocoa
import RxMoya
import RxSwift

enum CaveTarget {
    case getAll(Int)
}

extension CaveTarget: BaseTargetType {
    
    var headers: [String : String]? {
        APIConstants.headerWithAuthorization
    }
    
    var authorizationType: AuthorizationType? {
        return .bearer
    }
    
    var path: String {
        switch self {
        case .getAll(let memberId):
            let newPath = URLConstant.seedDetailGet.replacingOccurrences(of: "{seedId}", with: String(memberId))
            return newPath
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAll:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getAll:
            return .requestPlain
        }
    }
    
    
}

struct CaveService: Networkable {
    typealias Target = CaveTarget
    private static let provider = makeProvider()

    // -> Observable<[CaveData]>
    static func getAllCaves(with memberId: Int) -> Single<Response> {
        return provider.rx.request(.getAll(memberId))
        
//        provider.rx.request(.getAll(memberId))
//            .asObservable()
//            .map { try JSONDecoder().decode([CaveData].self, from: $0.data)}
//            .catch { error in
//                print("❗️", error)
//                return Observable.just([])
//            }
    }
}

struct CaveData: Codable {
    var caveId: Int
    var caveName: String
}

struct SeedData: Codable {
    let caveName, insight, memo, source: String
    let url: String
    let isScraped: Bool
    let lockDate: String
    let remainingDays: Int
}
