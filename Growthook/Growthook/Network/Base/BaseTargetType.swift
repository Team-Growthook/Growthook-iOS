//
//  BaseTargetType.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 1/2/24.
//

import Foundation

import Moya

protocol BaseTargetType: TargetType {}

extension BaseTargetType {
    
    var baseURL: URL {
        return URL(string: URLConstant.baseURL)!
    }
}
