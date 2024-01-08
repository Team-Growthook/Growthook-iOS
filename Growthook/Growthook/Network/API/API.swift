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
    case getDetailSeed(Int)
    case postNewSeed(caveId: Int, parameter: NewSeedRequest)
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
            let newPath = URLConstant.caveAllGet.replacingOccurrences(of: "{memberId}", with: String(memberId))
            return newPath
        case .getDetailSeed(let seedId):
            let newPath = URLConstant.seedDetailGet
                .replacingOccurrences(of: "{seedId}", with: String(seedId))
            return newPath
        case .postNewSeed(let caveId, _):
            let newPath = URLConstant.seedPost
                .replacingOccurrences(of: "{caveId}", with: String(caveId))
            return newPath
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAll:
            return .get
        case .getDetailSeed:
            return .get
        case .postNewSeed:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getAll:
            return .requestPlain
        case .getDetailSeed:
            return .requestPlain
        case .postNewSeed(_, let parameter):
            let parameters = try! parameter.asParameter()
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
}

struct CaveService: Networkable {
    typealias Target = CaveTarget
    private static let provider = makeProvider()

    static func getAllCaves(with memberId: Int) -> Observable<[CaveData]> {
        return provider.rx.request(.getAll(memberId))
            .asObservable()
            .mapError()
            .decode(decodeType: [CaveData].self)
    }
    
    static func getDetailSeed(with seedId: Int) -> Observable<SeedData> {
        return provider.rx.request(.getDetailSeed(seedId))
            .asObservable()
            .mapError()
            .decode(decodeType: SeedData.self)
    }
    
    static func postNewSeed(caveId: Int, seed: NewSeedRequest) -> Observable<NewSeedResponse> {
        return provider.rx.request(.postNewSeed(caveId: caveId, parameter: seed))
            .asObservable()
            .mapError()
            .decode(decodeType: NewSeedResponse.self)
    }
}

struct NewSeedRequest: Codable {
    let insight, memo, source, url: String
    let goalMonth: Int
}

struct NewSeedResponse: Codable {
    let seedId: Int
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
