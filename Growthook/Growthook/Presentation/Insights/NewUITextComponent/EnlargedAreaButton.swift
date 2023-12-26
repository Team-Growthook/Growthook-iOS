//
//  EnlargedAreaButton.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 12/21/23.
//

import UIKit

    /// 상속 받아 사용할 수 있게, final 은 생략했습니다.
class EnlargedAreaButton: UIButton {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        super.point(inside: point, with: event)
        
        /// 모든 방향에 값 만큼 터치 영역 증가
        /// dx: x축이 dx만큼 증가 (음수여야 증가)
        let touchArea = bounds.insetBy(dx: -10, dy: -10)
        return touchArea.contains(point)
    }
}
