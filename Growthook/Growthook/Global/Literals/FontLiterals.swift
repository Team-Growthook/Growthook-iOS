//
//  FontLiterals.swift
//  Growthook
//
//  Created by KJ on 11/4/23.
//

import UIKit

enum AppleSDGothicNeo: String {
    case bold = "AppleSDGothicNeo-Bold"
    case regular = "AppleSDGothicNeo-Regular"
}

enum FontLevel {
    case head1
    case head2
    case head3
    case head4
    case body1_bold
    case body1_reg
    case body2_bold
    case body2_reg
    case body3_bold
    case body3_reg
    case detail1_bold
    case detail1_reg
    case detail2_bold
    case detail2_reg
    case detail3_reg
}

extension FontLevel {
    
    var fontWeight: String {
        switch self {
        case .head1, .head2, .head3, .head4:
            return AppleSDGothicNeo.bold.rawValue
        case .body1_bold, .body2_bold, .body3_bold:
            return AppleSDGothicNeo.bold.rawValue
        case .body1_reg, .body2_reg, .body3_reg:
            return AppleSDGothicNeo.regular.rawValue
        case .detail1_bold, .detail2_bold:
            return AppleSDGothicNeo.bold.rawValue
        case .detail1_reg, .detail2_reg, .detail3_reg:
            return AppleSDGothicNeo.regular.rawValue
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .head1:
            return 24
        case .head2:
            return 22
        case .head3:
            return 20
        case .head4:
            return 18
        case .body1_bold, .body1_reg:
            return 16
        case .body2_bold, .body2_reg:
            return 15
        case .body3_bold, .body3_reg:
            return 14
        case .detail1_bold, .detail1_reg:
            return 13
        case .detail2_bold, .detail2_reg:
            return 12
        case .detail3_reg:
            return 11
        }
    }
}

extension UIFont {
    
    static func fontGuide(_ fontLevel: FontLevel) -> UIFont {
        return UIFont(name: fontLevel.fontWeight, size: fontLevel.fontSize)!
    }
}
