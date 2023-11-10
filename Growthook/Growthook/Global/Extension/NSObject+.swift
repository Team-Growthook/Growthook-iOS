//
//  NSObject+.swift
//  Growthook
//
//  Created by KJ on 11/4/23.
//

import Foundation

extension NSObject {

    static var className: String {
        NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
    }
}
