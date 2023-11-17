//
//  CaveProfileModel.swift
//  Growthook
//
//  Created by KJ on 11/10/23.
//

import UIKit

struct CaveProfileModel {
    let image: UIImage
    let title: String
}

extension CaveProfileModel {
    
    static func caveprofileDummyData() -> [CaveProfileModel] {
        return [
            CaveProfileModel(image: ImageLiterals.Home.img_cave, title: "하나"),
            CaveProfileModel(image: ImageLiterals.Home.img_cave, title: "둘"),
            CaveProfileModel(image: ImageLiterals.Home.img_cave, title: "셋셋셋"),
            CaveProfileModel(image: ImageLiterals.Home.img_cave, title: "넷넨네네"),
            CaveProfileModel(image: ImageLiterals.Home.img_cave, title: "다섯다섯다섯"),
            CaveProfileModel(image: ImageLiterals.Home.img_cave, title: "최대일곱글자야")
        ]
    }
}
