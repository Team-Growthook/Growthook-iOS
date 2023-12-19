//
//  ActionPlanModel.swift
//  Growthook
//
//  Created by Minjoo Kim on 11/22/23.
//

import Foundation

struct ActionPlanModel {
    let insightId: String
    let action: [action]
}

struct action {
    let actionId: String
    let actionText: String
}
