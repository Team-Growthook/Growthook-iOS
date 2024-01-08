//
//  ObservableType+.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 1/7/24.
//

import Foundation

import Moya
import RxSwift

extension Observable where Element == Response {
    
    /**
     Response 타입을 리턴하는 Observable 로써, statusCode 에 따라 구분합니다.
     */
    func mapError() -> Observable<Response> {
        flatMap { element -> Observable<Response> in
            .create { observer in
                switch element.statusCode {
                case 200...299:
                    observer.onNext(element)
                case 300...399:
                    print("👉🏻 Redirecting is Possible.")
                    observer.onNext(element)
                case 400...499:
                    /// 이 400 대 에러에 대해서는 추후에 백엔드분들께서 에러 케이스를 정리해주시면 그에 따라 어떤 error 를 방출할지 정하면 됩니다.
                    observer.onError(ServiceError.invalidResponse(responseCode: element.statusCode, message: element.description))
                default:
                    break
                }
                return Disposables.create()
            }
        }
    }
    
    /**
     해당 타입을 명시하여, 해당 타입으로 디코딩합니다.
     */
    func decode<Result: Codable>(decodeType: Result.Type) -> Observable<Result> {
        flatMap { element -> Observable<Result> in
            .create { observer in
                do {
                    guard let decoded = try JSONDecoder().decode(GeneralResponse<Result>.self, from: element.data).data else { return Disposables.create() }
                    observer.onNext(decoded)
                } catch let error {
                    observer.onError(error)
                }
                return Disposables.create()
            }
        }
    }
}
