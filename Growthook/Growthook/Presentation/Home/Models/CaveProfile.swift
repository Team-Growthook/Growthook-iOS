//
//  CaveProfileModel.swift
//  Growthook
//
//  Created by KJ on 11/10/23.
//

import UIKit

struct CaveProfile {
    let image: UIImage
    let title: String
}

extension CaveProfile {
    
    static func caveprofileDummyData() -> [CaveProfile] {
        return [
            CaveProfile(image: ImageLiterals.Home.img_cave_sunrise, title: "하나"),
            CaveProfile(image: ImageLiterals.Home.img_cave_pink, title: "둘"),
            CaveProfile(image: ImageLiterals.Home.img_cave_night, title: "셋셋셋"),
            CaveProfile(image: ImageLiterals.Home.img_cave_sunrise, title: "넷넨네네"),
            CaveProfile(image: ImageLiterals.Home.img_cave_night, title: "다섯다섯다섯"),
            CaveProfile(image: ImageLiterals.Home.img_cave_pink, title: "최대일곱글자야")
        ]
    }
}
