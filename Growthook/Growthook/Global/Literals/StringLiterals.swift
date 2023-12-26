//
//  StringLiterals.swift
//  Growthook
//
//  Created by KJ on 11/4/23.
//

import Foundation

enum I18N {
    
    enum Component {
        
        enum UnLockInsight {
            static let title = "잠금 해제하기"
            static let description = "씨앗의 잠금을 해제하기 위해\n쑥 1개를 사용합니다."
            static let insightTip = "Tip. 인사이트의 액션 플랜을 만들고 이를 달성하면,\n쑥을 얻을 수 있어요!"
            static let tip = "Tip."
            static let leftover = "현재 남은 쑥"
            static let giveUp = "포기하기"
            static let use = "사용하기"
        }
        
        enum RemoveInsight {
            static let title = "정말로 삭제할까요?"
            static let description = "삭제한 인사이트는 다시 복구할 수 없으니\n신중하게 결정해 주세요!"
            static let keep = "유지하기"
            static let remove = "삭제하기"
        }
        
        enum UnLockCave {
            static let title = "내 동굴에 친구를 초대해\n인사이트를 공유해요!"
            static let description = "해당 기능은 추후 업데이트 예정이에요:)"
            static let check = "확인"
        }
    }
    
    enum Home {
        static let select = "선택"
        static let seedsCollected = "개의 씨앗을 모았어요!"
        static let notiDescription1 = "잠금이 "
        static let notiDescription2 = "일 이하로\n남은 씨앗이 "
        static let notiDescription3 = "개 있어요!"
        static let caveName = "동굴 이름"
    }
    
    enum CaveDetail {
        static let addSeed = "씨앗 심기"
    }
    
    enum InsightList {
        static let lockInsight = "일 후 잠금"
    }
    
    enum ActionList {
        static let reviewPlaceholder = "액션 플랜을 달성하며 어떤 것을 느꼈는지 작성해보세요"
    }
}
