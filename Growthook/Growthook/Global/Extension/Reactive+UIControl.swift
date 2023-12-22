//
//  Reactive+UIControl.swift
//  Growthook
//
//  Created by KYUBO A. SHIM on 12/20/23.
//

import UIKit

import RxCocoa
import RxSwift

struct TargetedControlEvent<T> {
    var event: UIControl.Event
    var target: T
}

/**
 필요한 UIControl 에 해당하는 케이스를 추가하여 사용하시면 됩니다.
 - Default 케이스는 다음과 같습니다.
    - .editingDidBegin
    - .editingDidEnd
    - .editingDidEndOnExit
 */
enum TextHandlingEventsCases: CaseIterable {
    case editDidBegin
    case editDidEnd
    case editDidEndOnExit
    
    var event: UIControl.Event {
        switch self {
        case .editDidBegin:
            return .editingDidBegin
        case .editDidEnd:
            return .editingDidEnd
        case .editDidEndOnExit:
            return .editingDidEndOnExit
        }
    }
}

extension Reactive where Base: UIControl {
    
    /**
     UITextField 에서 쓰이는 UIControl Event 처리 변수입니다.
     - UITextField 에서 받은 UIControl Event 를 rx. 으로 처리할 수 있습니다.
     - Note: **TextHandlingEventsCases**: 필요한 Event 를 해당 enum 에 추가하여 사용할 수 있습니다.
     */
    var editingActions: Observable<TargetedControlEvent<Base>> {
        let events: [UIControl.Event] = TextHandlingEventsCases.allCases.map{$0.event}
        let eventObservables = events.map({controlEvent(event: $0)})
        return Observable.merge(eventObservables)
    }
    
    func controlEvent(event: UIControl.Event) -> Observable<TargetedControlEvent<Base>> {
        let targetedControlEvent = TargetedControlEvent(event: event, target: base)
        return base.rx.controlEvent(event).map({ _ in targetedControlEvent })
    }
}


